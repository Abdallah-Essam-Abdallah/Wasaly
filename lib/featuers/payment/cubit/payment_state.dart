part of 'payment_cubit.dart';

sealed class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

final class PaymentInitial extends PaymentState {}

final class MakePaymentLoadingState extends PaymentState {}

final class MakePaymentLoadedState extends PaymentState {}

final class MakePaymentErrorState extends PaymentState {
  final String error;

  const MakePaymentErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
