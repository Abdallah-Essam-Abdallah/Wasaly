part of 'authintecation_cubit.dart';

sealed class AuthintecationState extends Equatable {
  const AuthintecationState();

  @override
  List<Object> get props => [];
}

final class AuthintecationInitial extends AuthintecationState {}

class AuthenticationLoadingState extends AuthintecationState {}

class AuthenticationSignUpLoadedState extends AuthintecationState {}

class AuthenticationSignInWithEmailAndPassworsLoadedState
    extends AuthintecationState {}

class ResetPasswordLoadingState extends AuthintecationState {}

class ResetPasswordLoadedState extends AuthintecationState {}

class ResetPasswordErrorState extends AuthintecationState {
  final String error;

  const ResetPasswordErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class AuthenticationSignInWithGoogleLoadedState extends AuthintecationState {
  final User user;

  const AuthenticationSignInWithGoogleLoadedState({required this.user});
  @override
  List<Object> get props => [user];
}

class AuthenticationErrorState extends AuthintecationState {
  final String error;

  const AuthenticationErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class CreateUserInDatabaseLoadingState extends AuthintecationState {}

class CreateUserInDatabaseLoadedState extends AuthintecationState {}

class CreateUserInDatabaseErrorState extends AuthintecationState {
  final String error;

  const CreateUserInDatabaseErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class VerifyEmailLoadingState extends AuthintecationState {}

class VerifyEmailLoadedState extends AuthintecationState {}

class VerifyEmailErrorState extends AuthintecationState {
  final String error;

  const VerifyEmailErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
