import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:delivery_app/core/consts/app_consts.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
part 'pharmacy_state.dart';

class PharmacyCubit extends Cubit<PharmacyState> {
  PharmacyCubit() : super(PharmacyInitial());
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<void> uploadPrescription() async {
    if (await AppConsts.internetConnection.isInternetConnected) {
      try {
        emit(UploadPrescriptionLoadingState());
        ImagePicker imagePicker = ImagePicker();
        XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

        if (file == null) {
          emit(const UploadPrescriptionErrorState(
              error: AppStrings.noImageChoosedError));
        } else {
          Reference referenceRoot = FirebaseStorage.instance.ref();
          Reference refrenceDirImages = referenceRoot.child('images');
          Reference referenceImageToUpload = refrenceDirImages.child(file.name);
          await referenceImageToUpload.putFile(File(file.path));
          String imageUrl = await referenceImageToUpload.getDownloadURL();

          print(file.path);
          emit(UploadPrescriptionLoadedState(image: imageUrl));
          // return imageUrl;
        }
      } catch (e) {
        print(e);

        emit(const UploadPrescriptionErrorState(
            error: AppStrings.imageUploadError));
      }
    } else {
      emit(const UploadPrescriptionErrorState(
          error: AppStrings.internetFaliureMessage));
    }
  }
}
