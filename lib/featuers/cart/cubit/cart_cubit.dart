import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/core/consts/app_consts.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/featuers/cart/model/cart_item_model.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  int productCount = 1;

  void resetProductCount() {
    productCount = 1;
    emit(ResetProductCountState());
  }

  void increaseProductCount() {
    emit(ProductCountInitialState());
    productCount++;
    emit(IncreaseProductCountState());
  }

  void dicreaseProductCount() {
    emit(ProductCountInitialState());
    if (productCount == 1) {
      null;
    } else {
      productCount--;
    }
    emit(DecreaseProductCountState());
  }

  Future<void> addItemToCart({
    required Map<String, dynamic> cartItem,
    required int quantity,
    required int price,
  }) async {
    emit(AddItemToCartLoadingState());
    if (await AppConsts.internetConnection.isInternetConnected) {
      try {
        CartItem cartModel =
            CartItem(cartItem: cartItem, quantity: quantity, price: price);
        AppConsts.firebaseFirestore
            .collection(AppStrings.users)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection(AppStrings.cart)
            .add(cartModel.toJson());
        emit(AddItemToCartLoadedState());
      } catch (e) {
        emit(const AddItemToCartErrorState(
            error: AppStrings.unexpectedException));
      }
    } else {
      emit(const AddItemToCartErrorState(
          error: AppStrings.internetFaliureMessage));
    }
  }

  Future<void> deleteCartItem({required int index}) async {
    emit(RemoveCartItemLoadingState());

    if (await AppConsts.internetConnection.isInternetConnected) {
      try {
        final cartReference = AppConsts.firebaseFirestore
            .collection(AppStrings.users)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection(AppStrings.cart);

        final cartSnapshot = await cartReference.get();
        final docIdToDelete = cartSnapshot.docs[index].id;

        await cartReference.doc(docIdToDelete).delete();
        final currentState = state;
        if (currentState is GetCartItemsLoadedState) {
          final updatedCartItems = List<CartItem>.from(currentState.cartItems);
          updatedCartItems.removeAt(index);

          emit(GetCartItemsLoadedState(cartItems: updatedCartItems));
        } else {
          getCartItems();
        }

        emit(RemoveCartItemLoadedState());
      } catch (e) {
        emit(const RemoveCartItemErrorState(
            error: AppStrings.unexpectedException));
      }
    } else {
      emit(const RemoveCartItemErrorState(
          error: AppStrings.internetFaliureMessage));
    }
  }

  Future<void> clearCart() async {
    emit(ClearCartLoadingState());
    if (await AppConsts.internetConnection.isInternetConnected) {
      try {
        final CollectionReference ref = FirebaseFirestore.instance
            .collection(AppStrings.users)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection(AppStrings.cart);

        await ref.get().then((snapshot) {
          for (DocumentSnapshot doc in snapshot.docs) {
            doc.reference.delete();
          }
        });

        emit(ClearCartLoadedState());
      } catch (e) {
        emit(const ClearCartErrorState(error: AppStrings.unexpectedException));
      }
    } else {
      emit(const ClearCartErrorState(error: AppStrings.internetFaliureMessage));
    }
  }

  Future getCartItems() async {
    emit(GetCartItemsLoadingState());
    if (await AppConsts.internetConnection.isInternetConnected) {
      try {
        final QuerySnapshot<Map<String, dynamic>> cartResponse = await AppConsts
            .firebaseFirestore
            .collection(AppStrings.users)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection(AppStrings.cart)
            .get();

        final List<CartItem> cartItems = cartResponse.docs
            .map((cartItem) => CartItem.fromJson(cartItem.data()))
            .toList();
        emit(GetCartItemsLoadedState(cartItems: cartItems));
      } catch (e) {
        emit(const GetCartItemsErrorState(
            error: AppStrings.unexpectedException));
      }
    } else {
      emit(const GetCartItemsErrorState(
          error: AppStrings.internetFaliureMessage));
    }
  }

  int getTotalPrice({required List<CartItem> cartItems}) {
    int totalPrice = 0;
    for (CartItem item in cartItems) {
      totalPrice += item.price;
    }
    return totalPrice;
  }
}
