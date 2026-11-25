import 'package:getin_driver/features/home/domain/model/order_list_model/order_model.dart';

import '../../../../core/data_source/dio_helper.dart';

//put it in locators locator.registerLazySingleton(() => OrderDetailsRepository(locator<DioService>()));
//  import '../../modules/order_details/domain/repository/repository.dart';
class OrderDetailsRepository {
  final DioService dioService;
  OrderDetailsRepository(this.dioService);
  Future<OrderModel?> confirmOrder(int orderId) async {
    final response = await dioService.postData(
      url: "driver/orders/book-order/$orderId",
      loading: true,
    );
    if (response.isError == false) {
      return OrderModel.fromJson(response.response?.data["data"]);
    } else {
      return null;
    }
  }
}
