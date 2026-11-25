part of 'staticpage_cubit.dart';

sealed class StaticpageState extends Equatable {
  const StaticpageState();

  @override
  List<Object?> get props => [];
}

final class StaticpageInitial extends StaticpageState {}

final class GetTermsLoading extends StaticpageState {}

final class GetTermsSucess extends StaticpageState {
  final TermsModel terms;

  const GetTermsSucess({required this.terms});

  @override
  List<Object?> get props => [terms];
}

final class GetTermsFailed extends StaticpageState {
  final String? message;

  const GetTermsFailed({this.message});

  @override
  List<Object?> get props => [message];
}
