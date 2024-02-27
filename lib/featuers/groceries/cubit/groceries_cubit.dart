import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/core/network/internet_connection.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/featuers/groceries/model/groceries_product_model.dart';
import 'package:equatable/equatable.dart';

part 'groceries_state.dart';

class GroceriesCubit extends Cubit<GroceriesState> {
  GroceriesCubit() : super(GroceriesInitial());

  final InternetConnection internetConnection = InternetConnection();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future getGroceriesProducts() async {
    emit(GetGroceriesProductsLoadingState());
    if (await internetConnection.isInternetConnected) {
      try {
        final QuerySnapshot<Map<String, dynamic>> productsResponse =
            await firebaseFirestore.collection(AppStrings.groceries).get();

        final List<GroceriesProductModel> products = productsResponse.docs
            .map((product) => GroceriesProductModel.fromJson(product.data()))
            .toList();

        emit(GetGroceriesProductsLoadedState(products: products));
      } catch (e) {
        print(e.toString());
        emit(const GetGroceriesProductsErrorState(
            error: AppStrings.unexpectedException));
      }
    } else {
      emit(const GetGroceriesProductsErrorState(
          error: AppStrings.internetFaliureMessage));
    }
  }
}
