part of 'orders_cubit.dart';

sealed class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => [];
}

final class OrdersInitial extends OrdersState {}

final class PlaceOrderLoadingState extends OrdersState {}

final class PlaceOrderLoadedState extends OrdersState {}

final class PlaceOrderErrorState extends OrdersState {
  final String error;

  const PlaceOrderErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

final class GetOrdersLoadingState extends OrdersState {}

final class GetOrdersLoadedState extends OrdersState {
  final List<OrderModel> orders;

  const GetOrdersLoadedState({required this.orders});

  @override
  List<Object> get props => [orders];
}

final class GetOrdersErrorState extends OrdersState {
  final String error;

  const GetOrdersErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

final class CancelOrderLoadingState extends OrdersState {}

final class CancelOrderLoadedState extends OrdersState {}

final class CancelOrderErrorState extends OrdersState {
  final String error;

  const CancelOrderErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
