import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/core/consts/app_consts.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/featuers/resturants/model/menu_item_model.dart';
import 'package:delivery_app/featuers/resturants/model/returant_model.dart';
import 'package:equatable/equatable.dart';

part 'resturants_state.dart';

class ResturantsCubit extends Cubit<ResturantsState> {
  ResturantsCubit() : super(ResturantsInitial());

  Future getResturants() async {
    emit(GetResturantsLoadingState());
    if (await AppConsts.internetConnection.isInternetConnected) {
      try {
        final QuerySnapshot<Map<String, dynamic>> resturantsResponse =
            await AppConsts.firebaseFirestore
                .collection(AppStrings.resturants)
                .get();

        final List<ResturantModel> resturants = resturantsResponse.docs
            .map((resturant) => ResturantModel.fromJson(resturant.data()))
            .toList();

        emit(GetResturantsLoadedState(resturants: resturants));
      } catch (e) {
        emit(const GetResturantsErrorState(
            error: AppStrings.unexpectedException));
      }
    } else {
      emit(const GetResturantsErrorState(
          error: AppStrings.internetFaliureMessage));
    }
  }

  Future getResturantMenu({required String title}) async {
    emit(GetResturantMenuLoadingState());
    if (await AppConsts.internetConnection.isInternetConnected) {
      try {
        final QuerySnapshot<Map<String, dynamic>> menuItemResponse =
            await AppConsts.firebaseFirestore
                .collection(AppStrings.resturants)
                .where('title', isEqualTo: title)
                .get();

        final DocumentSnapshot<Map<String, dynamic>> firstDocSnapshot =
            menuItemResponse.docs.first;

        final CollectionReference<Map<String, dynamic>> collectionRef =
            firstDocSnapshot.reference.collection('Menu');

        final QuerySnapshot<Map<String, dynamic>> docsSnapshot =
            await collectionRef.get();

        final List<MenuItemModel> menuItems = docsSnapshot.docs
            .map((menuItem) => MenuItemModel.fromJson(menuItem.data()))
            .toList();

        emit(GetResturantMenuLoadedState(menuItems: menuItems));
      } catch (e) {
        emit(const GetResturantMenuErrorState(
            error: AppStrings.unexpectedException));
      }
    } else {
      emit(const GetResturantMenuErrorState(
          error: AppStrings.internetFaliureMessage));
    }
  }
}
