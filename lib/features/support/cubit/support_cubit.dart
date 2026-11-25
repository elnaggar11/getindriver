import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:getin_driver/core/data_source/dio_helper.dart';
import 'package:getin_driver/core/utils/Locator.dart';
import 'package:getin_driver/features/support/domain/model/support_model.dart';
import 'package:getin_driver/features/support/domain/repository/support_repository.dart';

part 'support_state.dart';

class SupportCubit extends Cubit<SupportState> {
  SupportCubit() : super(SupportInitial());

  final SupportRepository _repository = SupportRepository(
    locator<DioService>(),
  );

  Future<void> getSupport() async {
    emit(SupportLoading());
    try {
      final result = await _repository.getSupport();
      if (result.data != null) {
        emit(SupportSuccess(supportModel: result.data!));
      } else {
        emit(SupportFailed(message: result.errorMessage));
      }
    } catch (_) {
      emit(const SupportFailed());
    }
  }
}
