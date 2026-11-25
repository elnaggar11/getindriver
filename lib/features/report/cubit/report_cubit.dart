import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../core/utils/Locator.dart';
import '../domain/model/report_model.dart';
import '../domain/repository/repository.dart';
import 'report_states.dart';

class ReportCubit extends Cubit<ReportStates> {
  ReportCubit() : super(ReportInitial());
  static ReportCubit get(context) => BlocProvider.of(context);

  ReportRepository reportRepository = locator<ReportRepository>();

  PagingController<int, ReviewModel> reviewsController =
      PagingController<int, ReviewModel>(firstPageKey: 1);

  late void Function(int) _pageRequestListener;

  void addPageListener() {
    _pageRequestListener = (pageKey) {
      getReviews(page: pageKey);
    };
    reviewsController.addPageRequestListener(_pageRequestListener);
  }

  refresh() {
    reviewsController.refresh();
  }

  getReviews({required int page}) async {
    final response = await reportRepository.getReviews(page);
    if (response != null) {
      final bool isLastPage = response.lastPage == page;
      if (isLastPage) {
        reviewsController.appendLastPage(response.reviews);
      } else {
        final int nextPageKey = page + 1;
        reviewsController.appendPage(response.reviews, nextPageKey);
      }
      emit(ReportGetReviewsFinished());
    } else {
      reviewsController.error = 'error';
      emit(ReportGetReviewsError());
    }
  }
}
