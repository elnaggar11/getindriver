abstract class NotificationsStates {}

final class NotificationsInitial extends NotificationsStates {}

final class DeleteNotificationsDataLoading extends NotificationsStates {}

final class DeleteNotificationsDataSuccess extends NotificationsStates {
  final String message;

  DeleteNotificationsDataSuccess({required this.message});
}

final class DeleteNotificationsDataError extends NotificationsStates {
  final String message;

  DeleteNotificationsDataError({required this.message});
}

final class DeleteOnlyOneNotificationDataLoading extends NotificationsStates {}

final class DeleteOnlyOneNotificationDataSuccess extends NotificationsStates {
  final String message;

  DeleteOnlyOneNotificationDataSuccess({required this.message});
}

final class DeleteOnlyOneNotificationDataError extends NotificationsStates {
  final String message;

  DeleteOnlyOneNotificationDataError({required this.message});
}

class GetNotificationsDataLoading extends NotificationsStates {}

class GetNotificationsDatafinish extends NotificationsStates {}

class GetNotificationsDataError extends NotificationsStates {}

class DeleteAllNotificationsDataLoading extends NotificationsStates {}

class DeleteAllNotificationsDataSuccess extends NotificationsStates {
  final dynamic message;

  DeleteAllNotificationsDataSuccess({required this.message});
}

class DeleteAllNotificationsDataError extends NotificationsStates {
  final dynamic message;

  DeleteAllNotificationsDataError({required this.message});
}
