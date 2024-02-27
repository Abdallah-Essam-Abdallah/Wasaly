part of 'discount_cubit.dart';

sealed class DiscountState extends Equatable {
  const DiscountState();

  @override
  List<Object> get props => [];
}

final class DiscountInitial extends DiscountState {}

final class ValidateCouponLoadingState extends DiscountState {}

final class ValidateCouponLoadedState extends DiscountState {
  final int priceAfterDiscount;
  final int discountValue;

  const ValidateCouponLoadedState({
    required this.priceAfterDiscount,
    required this.discountValue,
  });
  @override
  List<Object> get props => [priceAfterDiscount, discountValue];
}

final class ValidateCouponErrorState extends DiscountState {
  final String error;

  const ValidateCouponErrorState({required this.error});
  @override
  List<Object> get props => [error];
}
