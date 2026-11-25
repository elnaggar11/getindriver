import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getin_driver/features/home/domain/model/order_enum.dart';
import 'package:getin_driver/features/home/domain/model/order_list_model/order_list_model.dart';
import 'package:getin_driver/features/home/domain/model/order_list_model/order_model.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../core/utils/Locator.dart';
import '../domain/repository/repository.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);

  HomeRepository homeRepository = locator<HomeRepository>();
  OrderListModel? orderListModel;
  OrderStatus currentOrderStatus = OrderStatus.newOrder;
  String currentSearch = '';

  // PagingController for infinite_scroll_pagination
  PagingController<int, OrderModel> pagingController =
      PagingController<int, OrderModel>(firstPageKey: 1);

  late void Function(int) _pageRequestListener;

  void addPageListener() {
    _pageRequestListener = (pageKey) {
      getOrders(page: pageKey);
    };
    pagingController.addPageRequestListener(_pageRequestListener);
  }

  void refresh() {
    pagingController.refresh();
  }

  void setOrderStatus(OrderStatus status) {
    currentOrderStatus = status;
    emit(HomeInitial());
    pagingController.refresh();
  }

  void setSearch(String search) {
    currentSearch = search;
    emit(HomeInitial());
    pagingController.refresh();
  }

  Future<void> getOrders({int page = 1}) async {
    emit(GetOrdersLoading());
    final response = await homeRepository.getOrders(
      currentOrderStatus,
      search: currentSearch,
      page: page,
    );

    if (response != null) {
      orderListModel = response;
      final newItems = response.data ?? [];
      final isLastPage = response.lastPage == page;

      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = page + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
      emit(GetOrdersSuccess(response));
    } else {
      pagingController.error = 'error';
      emit(GetOrdersError());
    }
  }

  @override
  Future<void> close() {
    pagingController.dispose();
    return super.close();
  }
}
