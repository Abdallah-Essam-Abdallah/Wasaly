part of 'offers_cubit.dart';

sealed class OffersState extends Equatable {
  const OffersState();

  @override
  List<Object> get props => [];
}

final class OffersInitial extends OffersState {}

final class GetOffersLoadingState extends OffersState {}

final class GetOffersLoadedState extends OffersState {
  final List<OfferModel> offers;

  const GetOffersLoadedState({required this.offers});

  @override
  List<Object> get props => [offers];
}

final class GetOffersErrorState extends OffersState {
  final String error;

  const GetOffersErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
