part of 'qr_reader_cubit.dart';

sealed class QrReaderState extends Equatable {
  const QrReaderState();

  @override
  List<Object> get props => [];
}

final class QrReaderInitial extends QrReaderState {}


      class QrReaderLoading extends QrReaderState {}
      
    class QrReaderSuccess extends QrReaderState {
      final dynamic response;
    
      const QrReaderSuccess(this.response);
    }
    
      class QrReaderError extends QrReaderState {}
      