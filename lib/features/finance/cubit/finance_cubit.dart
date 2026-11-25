import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getin_driver/features/finance/domain/model/finance_model.dart';
import 'package:getin_driver/features/home/domain/model/order_list_model/order_model.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../core/utils/Locator.dart';
import '../domain/repository/repository.dart';
import 'finance_states.dart';

class FinanceCubit extends Cubit<FinanceStates> {
  FinanceCubit() : super(FinanceInitial());
  static FinanceCubit get(context) => BlocProvider.of(context);

  FinanceRepository financeRepository = locator<FinanceRepository>();
  PagingController<int, OrderModel> notificationsController =
      PagingController<int, OrderModel>(firstPageKey: 1);

  late void Function(int) _pageRequestListener;

  void addPageListener() {
    _pageRequestListener = (pageKey) {
      getFinance(pageKey);
    };

    notificationsController.addPageRequestListener(_pageRequestListener);
  }

  refresh() {
    notificationsController.refresh();
  }

  String status = "completed-orders";
  String currentSearch = "";

  void setStatus(String status) {
    this.status = status;
    emit(FinanceInitial());
    notificationsController.refresh();
  }

  void setSearch(String search) {
    currentSearch = search;
    emit(FinanceInitial());
    notificationsController.refresh();
  }

  FinanceModel? financeModel;
  Future<void> getFinance(int page) async {
    emit(FinanceLoading());
    final response = await financeRepository.getFinance(status,currentSearch,page:page);

    if (response != null) {
      financeModel = response;
      var isLastPage = response.lastPage == page;
      if (isLastPage) {
        // stop
        notificationsController.appendLastPage(response.orders);
      } else {
        var nextPageKey = page + 1;
        notificationsController.appendPage(response.orders, nextPageKey);
      }
      emit(GetFinanceDatafinish());
    } else {
      notificationsController.error = 'error';
      emit(GetFinanceDataError());
    }
  }
}
