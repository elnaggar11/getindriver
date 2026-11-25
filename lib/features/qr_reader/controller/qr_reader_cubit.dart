import 'package:getin_driver/core/localization/localization_helper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getin_driver/core/services/alerts.dart';
import 'package:getin_driver/core/utils/Locator.dart';
import 'package:getin_driver/features/qr_reader/domain/repository/repository.dart';
part 'qr_reader_state.dart';

class QrReaderCubit extends Cubit<QrReaderState> {
  final int? currentOrderId;
  QrReaderCubit(this.currentOrderId) : super(QrReaderInitial());
  static QrReaderCubit get(context) => BlocProvider.of(context);
  final QrReaderRepository qrReaderRepository = locator<QrReaderRepository>();
  void confirmClientRecieveOrder(String qrCodedata) async {
    emit(QrReaderLoading());
    const apiSegment = '/api/';

    final uri = Uri.parse(qrCodedata);

    final token = uri.queryParameters["token"];
    final orderId = uri.queryParameters["order_id"];
    final path = uri.path;
    final apiSegmentIndex = path.indexOf(apiSegment);
    String pathAfterApi = "";
    if (apiSegmentIndex != -1) {
      pathAfterApi = path.substring(apiSegmentIndex + apiSegment.length);
    }
    if (currentOrderId != null &&
        currentOrderId != int.parse(orderId ?? '-1')) {
      emit(QrReaderError());
      Alerts.snack(
        text: LocalizationHelper.tr.order_id_not_match,
        state: SnackState.failed,
      );
      return;
    }

    if (orderId == null || token == null) {
      emit(QrReaderError());
      return;
    }
    final response = await qrReaderRepository.confirmClientRecieveOrder(
      int.parse(orderId),
      token: token,
      url: pathAfterApi,
    );
    if (response != null) {
      emit(QrReaderSuccess(response));
    } else {
      emit(QrReaderError());
    }
  }
}
