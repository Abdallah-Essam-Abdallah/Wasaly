part of 'cart_cubit.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

final class ProductCountInitialState extends CartState {}

final class ResetProductCountState extends CartState {}

final class IncreaseProductCountState extends CartState {}

final class DecreaseProductCountState extends CartState {}

final class AddItemToCartLoadingState extends CartState {}

final class AddItemToCartLoadedState extends CartState {}

final class AddItemToCartErrorState extends CartState {
  final String error;

  const AddItemToCartErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

final class GetCartItemsLoadingState extends CartState {}

final class GetCartItemsLoadedState extends CartState {
  final List<CartItem> cartItems;

  const GetCartItemsLoadedState({required this.cartItems});

  @override
  List<Object> get props => [cartItems];
}

final class GetCartItemsErrorState extends CartState {
  final String error;

  const GetCartItemsErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

final class RemoveCartItemLoadingState extends CartState {}

final class RemoveCartItemLoadedState extends CartState {}

final class RemoveCartItemErrorState extends CartState {
  final String error;

  const RemoveCartItemErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

final class ClearCartLoadingState extends CartState {}

final class ClearCartLoadedState extends CartState {}

final class ClearCartErrorState extends CartState {
  final String error;

  const ClearCartErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
