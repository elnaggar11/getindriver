import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../core/data_source/dio_helper.dart';
import '../../../core/utils/Locator.dart';
import '../domain/model/notifications_model.dart';
import '../domain/repository/repository.dart';
import 'notifications_states.dart';

class NotificationsCubit extends Cubit<NotificationsStates> {
  NotificationsCubit() : super(NotificationsInitial());
  static NotificationsCubit get(context) => BlocProvider.of(context);

  NotificationsRepository notificationsRepository =
      NotificationsRepository(locator<DioService>());
  PagingController<int, NotificationModel> notificationsController =
      PagingController<int, NotificationModel>(firstPageKey: 1);

  late void Function(int) _pageRequestListener;

  void addPageListener() {
    _pageRequestListener = (pageKey) {
      getNotifications(page: pageKey);
    };

    notificationsController.addPageRequestListener(_pageRequestListener);
  }

  refresh() {
    notificationsController.refresh();
  }

  deleteAllNotifications() async {
    emit(DeleteAllNotificationsDataLoading());
    final response = await notificationsRepository.deleteNotifications();
    if (response != null) {
      notificationsController.refresh();

      emit(DeleteAllNotificationsDataSuccess(message: response['message']));
    } else {
      notificationsController.error = 'error';
      emit(DeleteAllNotificationsDataError(message: response['message']));
    }
  }

  getNotifications({required int page}) async {
    emit(GetNotificationsDataLoading());
    final response = await notificationsRepository.getNotifications(page);

    if (response != null) {
      var isLastPage = response.lastPage == page;
      if (isLastPage) {
        // stop
        notificationsController.appendLastPage(
          response.notifications,
        );
      } else {
        var nextPageKey = page + 1;
        notificationsController.appendPage(
          response.notifications,
          nextPageKey,
        );
      }
      emit(GetNotificationsDatafinish());
    } else {
      notificationsController.error = 'error';
      emit(GetNotificationsDataError());
    }
  }

  deleteNotifications() async {
    emit(DeleteNotificationsDataLoading());
    final response = await notificationsRepository.deleteNotifications();
    if (response != null) {
      notificationsController.refresh();

      emit(DeleteNotificationsDataSuccess(message: response['message']));
    } else {
      notificationsController.error = 'error';
      emit(DeleteNotificationsDataError(message: response['message']));
    }
  }

  deleteOnlyOneNotification({required String id}) async {
    emit(DeleteOnlyOneNotificationDataLoading());
    final response =
        await notificationsRepository.deleteOnlyOneNotification(id: id);
    if (response != null) {
      emit(DeleteOnlyOneNotificationDataSuccess(message: response['message']));
      notificationsController.refresh();
    } else {
      notificationsController.error = 'error';
      emit(DeleteOnlyOneNotificationDataError(message: response['message']));
    }
  }
}
