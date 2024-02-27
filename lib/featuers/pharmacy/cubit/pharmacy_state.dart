part of 'pharmacy_cubit.dart';

sealed class PharmacyState extends Equatable {
  const PharmacyState();

  @override
  List<Object> get props => [];
}

final class PharmacyInitial extends PharmacyState {}

final class UploadPrescriptionLoadingState extends PharmacyState {}

final class UploadPrescriptionLoadedState extends PharmacyState {
  final String image;

  const UploadPrescriptionLoadedState({required this.image});
  @override
  List<Object> get props => [image];
}

final class UploadPrescriptionErrorState extends PharmacyState {
  final String error;

  const UploadPrescriptionErrorState({required this.error});
  @override
  List<Object> get props => [error];
}
