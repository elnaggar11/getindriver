part of 'support_cubit.dart';

sealed class SupportState extends Equatable {
  const SupportState();

  @override
  List<Object?> get props => [];
}

final class SupportInitial extends SupportState {}

final class SupportLoading extends SupportState {}

final class SupportSuccess extends SupportState {
  final SupportModel supportModel;

  const SupportSuccess({required this.supportModel});

  @override
  List<Object?> get props => [supportModel];
}

final class SupportFailed extends SupportState {
  final String? message;

  const SupportFailed({this.message});

  @override
  List<Object?> get props => [message];
}
