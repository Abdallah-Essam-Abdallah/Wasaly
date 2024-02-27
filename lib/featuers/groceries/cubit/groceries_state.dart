part of 'groceries_cubit.dart';

sealed class GroceriesState extends Equatable {
  const GroceriesState();

  @override
  List<Object> get props => [];
}

final class GroceriesInitial extends GroceriesState {}

final class GetGroceriesProductsLoadingState extends GroceriesState {}

final class GetGroceriesProductsLoadedState extends GroceriesState {
  final List<GroceriesProductModel> products;

  const GetGroceriesProductsLoadedState({required this.products});

  @override
  List<Object> get props => [products];
}

final class GetGroceriesProductsErrorState extends GroceriesState {
  final String error;

  const GetGroceriesProductsErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
