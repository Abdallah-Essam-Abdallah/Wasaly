import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/core/network/internet_connection.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/featuers/authintecation/model/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final InternetConnection internetConnection = InternetConnection();
  UserModel? user;

  Future getUserData() async {
    emit(GetUserDataLoadingState());
    if (await internetConnection.isInternetConnected) {
      try {
        DocumentSnapshot<Map<String, dynamic>> userData =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(firebaseAuth.currentUser!.uid)
                .get();
        UserModel model = UserModel.fromJson(userData.data()!);
        user = model;
        emit(GetUserDataLoadedState(user: model));
        return model;
      } on FirebaseException catch (e) {
        print(e);
        emit(GetUserDataErrorState(error: e.toString()));
      }
    } else {
      emit(const GetUserDataErrorState(
          error: AppStrings.internetFaliureMessage));
    }
  }

  Future<void> signOut() async {
    emit(SignoutLoadingState());
    if (await internetConnection.isInternetConnected) {
      try {
        await firebaseAuth.signOut();
        emit(SignoutLoadedState());
      } catch (e) {
        print(e.toString());
        emit(const SignoutErrorState(error: AppStrings.unexpectedException));
      }
    } else {
      emit(const SignoutErrorState(error: AppStrings.internetFaliureMessage));
    }
  }
}
