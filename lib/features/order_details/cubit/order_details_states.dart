import 'package:getin_driver/features/home/domain/model/order_list_model/order_model.dart';

abstract class OrderDetailsStates {}

class OrderDetailsInitial extends OrderDetailsStates {}


      class OrderDetailsLoading extends OrderDetailsStates {}
      
    class OrderDetailsSuccess extends OrderDetailsStates {
      final OrderModel? response;
    
      OrderDetailsSuccess(this.response);
    }
    
      class OrderDetailsError extends OrderDetailsStates {}
      