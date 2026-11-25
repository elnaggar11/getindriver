import 'dart:developer';

import 'package:getin_driver/features/home/domain/model/order_list_model/order_model.dart';

import '../../../../core/data_source/dio_helper.dart';

class BranchMapRepository {
  final DioService dioService;
  BranchMapRepository(this.dioService);
  Future<OrderModel?> receiveOrder(int orderId) async {
    try {
      final response = await dioService.postData(
        url: "driver/orders/receive-order-branch/$orderId",
        loading: true,
      );
      if (response.isError == false) {
        return OrderModel.fromJson(response.response?.data["data"]);
      } else {
        return null;
      }
    } catch (e, trace) {
      log(trace.toString(), name: "trace");
      log(e.toString(), name: "e");
      return null;
    }
  }
}
