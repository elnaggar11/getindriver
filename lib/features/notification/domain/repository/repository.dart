import '../../../../core/data_source/dio_helper.dart';
import '../model/notifications_model.dart';

//put it in locators locator.registerLazySingleton(() => NotificationsRepository(locator<DioService>()));
//  import '../../modules/notifications/domain/repository/repository.dart';

class NotificationsRepository {
  final DioService dioService;
  NotificationsPagination? staticData;
  NotificationsRepository(this.dioService);
  Future<NotificationsPagination?> getNotifications(int? page) async {
    final ApiResponse response =
        await dioService.getData(url: 'notifications', query: {"page": page});
    if (response.isError == false) {
      return NotificationsPagination.fromJson(response.response?.data);
    } else {
      return null;
    }
  }

  

  Future deleteNotifications() async {
    final response = await dioService.deleteData(url: 'notifications');
    if (response.isError == false) {
      return response.response?.data;
    } else {
      return null;
    }
  }

  Future deleteOnlyOneNotification({required String id}) async {
    final response =
        await dioService.deleteData(url: 'notifications/$id', loading: true);
    if (response.isError == false) {
      return response.response?.data;
    } else {
      return null;
    }
  }
}
