import 'package:getin_driver/features/home/domain/model/order_list_model/order_list_model.dart';

abstract class HomeStates {}

class HomeInitial extends HomeStates {}

class HomeLoading extends HomeStates {}

class HomeSuccess extends HomeStates {
  final OrderListModel? response;

  HomeSuccess(this.response);
}

class HomeError extends HomeStates {}

class GetOrdersLoading extends HomeStates {}

class GetOrdersSuccess extends HomeStates {
  final OrderListModel? response;

  GetOrdersSuccess(this.response);
}

class GetOrdersError extends HomeStates {}
