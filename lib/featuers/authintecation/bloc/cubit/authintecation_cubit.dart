import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/core/network/internet_connection.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/featuers/authintecation/model/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
part 'authintecation_state.dart';

class AuthintecationCubit extends Cubit<AuthintecationState> {
  AuthintecationCubit() : super(AuthintecationInitial());

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final InternetConnection internetConnection = InternetConnection();

  Future<void> signUp({
    required String email,
    required String password,
    required String userName,
    required String phoneNumber,
  }) async {
    emit(AuthenticationLoadingState());
    if (await internetConnection.isInternetConnected) {
      try {
        final user = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);

        await createUserInDatabase(
            userName: userName,
            email: email,
            phoneNumber: phoneNumber,
            userId: user.user!.uid);
        await verifyEmail();
        emit(AuthenticationSignUpLoadedState());
      } on FirebaseAuthException catch (e) {
        print(e);
        switch (e.code) {
          case 'email-already-in-use':
            emit(const AuthenticationErrorState(
                error: AppStrings.emailAlreadyInUseException));
          case 'invalid-email':
            emit(
                const AuthenticationErrorState(error: AppStrings.invalidEmail));
          case 'weak-password':
            emit(const AuthenticationErrorState(
                error: AppStrings.weakPasswordException));
        }
      }
    } else {
      emit(const AuthenticationErrorState(
          error: AppStrings.internetFaliureMessage));
    }
  }

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    emit(AuthenticationLoadingState());
    if (await internetConnection.isInternetConnected) {
      try {
        final result = await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        emit(AuthenticationSignInWithEmailAndPassworsLoadedState());
        print(result.user!.email);
      } on FirebaseAuthException catch (e) {
        print('this errror${e.code}');
        switch (e.code) {
          case 'too-many-requests':
            emit(const AuthenticationErrorState(
                error: AppStrings.tooManyRequests));
          case 'wrong-password':
            emit(const AuthenticationErrorState(
                error: AppStrings.wrongPasswordException));
          case 'invalid-email':
            emit(const AuthenticationErrorState(
                error: AppStrings.invalidEmailException));
          case 'user-not-found':
            emit(const AuthenticationErrorState(
                error: AppStrings.userNotFoundException));
          case 'invalid-credential':
            emit(const AuthenticationErrorState(
                error: AppStrings.invalidCredential));
        }
      }
    } else {
      emit(const AuthenticationErrorState(
          error: AppStrings.internetFaliureMessage));
    }
  }

  Future<void> createUserInDatabase({
    required String userName,
    required String email,
    required String phoneNumber,
    required String userId,
  }) async {
    UserModel model = UserModel(
      userName: userName,
      userId: firebaseAuth.currentUser!.uid,
      email: email,
      phoneNumber: phoneNumber,
    );

    firebaseFirestore
        .collection(AppStrings.users)
        .doc(userId)
        .set(model.toJson());
  }

  Future<void> verifyEmail() async {
    emit(VerifyEmailLoadingState());
    if (await internetConnection.isInternetConnected) {
      try {
        bool isEmailVerified = false;
        isEmailVerified = firebaseAuth.currentUser!.emailVerified;
        if (!isEmailVerified) {
          final user = firebaseAuth.currentUser!;
          await user.sendEmailVerification();
        }
      } catch (e) {
        emit(
            const VerifyEmailErrorState(error: AppStrings.unexpectedException));
      }
    } else {
      emit(const AuthenticationErrorState(
          error: AppStrings.internetFaliureMessage));
    }
  }

  Future<void> resetPassword({required String email}) async {
    emit(ResetPasswordLoadingState());
    if (await internetConnection.isInternetConnected) {
      try {
        await firebaseAuth.sendPasswordResetEmail(email: email);
        emit(ResetPasswordLoadedState());
      } on FirebaseAuthException catch (e) {
        print(e.message);
        emit(const ResetPasswordErrorState(
            error: AppStrings.unexpectedException));
      }
    } else {
      emit(const AuthenticationErrorState(
          error: AppStrings.internetFaliureMessage));
    }
  }
}
