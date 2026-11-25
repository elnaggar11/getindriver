import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/Locator.dart';
import '../domain/repository/repository.dart';
import 'order_details_states.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsStates> {
  OrderDetailsCubit() : super(OrderDetailsInitial());
  static OrderDetailsCubit get(context) => BlocProvider.of(context);

  OrderDetailsRepository orderDetailsRepository =
      locator<OrderDetailsRepository>();
  Future<void> confirmOrder(int orderId) async {
    emit(OrderDetailsLoading());
    final response = await orderDetailsRepository.confirmOrder(orderId);
    if (response != null) {
      emit(OrderDetailsSuccess(response));
    } else {
      emit(OrderDetailsError());
    }
  }
}
