part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class GetUserDataLoadingState extends ProfileState {}

final class GetUserDataLoadedState extends ProfileState {
  final UserModel user;

  const GetUserDataLoadedState({required this.user});
  @override
  List<Object> get props => [user];
}

final class GetUserDataErrorState extends ProfileState {
  final String error;

  const GetUserDataErrorState({required this.error});
  @override
  List<Object> get props => [error];
}

final class SignoutLoadingState extends ProfileState {}

final class SignoutLoadedState extends ProfileState {}

final class SignoutErrorState extends ProfileState {
  final String error;

  const SignoutErrorState({required this.error});
  @override
  List<Object> get props => [error];
}
