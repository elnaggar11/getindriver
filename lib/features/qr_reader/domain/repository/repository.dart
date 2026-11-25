import 'dart:developer';


import '../../../../core/data_source/dio_helper.dart';

class QrReaderRepository {
  final DioService dioService;
  QrReaderRepository(this.dioService);
  Future<dynamic> confirmClientRecieveOrder(
    int orderId, {
    String? token,
   required String url,
  }) async {
    try {
      final response = await dioService.postData(
        url: url,
        loading: true,
        body: {"token": token},
      );
      if (response.isError == false) {
        return response.response?.data["data"];
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
