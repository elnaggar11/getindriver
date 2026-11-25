import 'dart:developer';

import 'package:getin_driver/features/home/domain/model/order_enum.dart';
import 'package:getin_driver/features/home/domain/model/order_list_model/order_list_model.dart';

import '../../../../core/data_source/dio_helper.dart';

//put it in locators locator.registerLazySingleton(() => HomeRepository(locator<DioService>()));
//  import '../../modules/home/domain/repository/repository.dart';
class HomeRepository {
  final DioService dioService;
  HomeRepository(this.dioService);
  Future<OrderListModel?> getOrders(
    OrderStatus orderStatus, {
    String? search,
    int page = 1,
  }) async {
    try {
      final response = await dioService.getData(
        url: "driver/orders/${orderStatus.backendName}",
        query: {
          'page': page,
          if (search != null && search.isNotEmpty) 'order_num': search,
        },
        //  parser: (data) => HomeModel.fromJson(data),
      );
      if (response.isError == false) {
        return OrderListModel.fromJson(response.response?.data);
      } else {
        return null;
      }
    } catch (e, s) {
      log(e.toString(), error: e, stackTrace: s);
      return null;
    }
  }
}
