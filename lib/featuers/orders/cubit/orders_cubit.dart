import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/core/consts/app_consts.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/featuers/orders/model/order_model.dart';
import 'package:equatable/equatable.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());

  Future<void> placeOrder({
    required List<Map<String, dynamic>> cartItems,
    required int finalPrice,
    required double lat,
    required double lng,
    required String userName,
    required String paymentMethod,
    required String paymentStatus,
    required String orderId,
    String? note,
  }) async {
    emit(PlaceOrderLoadingState());
    if (await AppConsts.internetConnection.isInternetConnected) {
      try {
        OrderModel orderModel = OrderModel(
            cartItems: cartItems,
            finalPrice: finalPrice,
            lat: lat,
            lng: lng,
            userName: userName,
            status: 'Submitted',
            paymentMethod: paymentMethod,
            orderId: orderId,
            paymentStatus: paymentStatus,
            userId: AppStrings.userId,
            deliveryGuy: '',
            note: note ?? '',
            orderTime: DateTime.now().toString());

        AppConsts.firebaseFirestore
            .collection(AppStrings.orders)
            .doc()
            .set(orderModel.toJson());
        emit(PlaceOrderLoadedState());
      } catch (e) {
        emit(const PlaceOrderErrorState(error: AppStrings.unexpectedException));
      }
    } else {
      emit(
          const PlaceOrderErrorState(error: AppStrings.internetFaliureMessage));
    }
  }

  Future getOrders() async {
    emit(GetOrdersLoadingState());
    if (await AppConsts.internetConnection.isInternetConnected) {
      try {
        final QuerySnapshot<Map<String, dynamic>> ordersResponse =
            await AppConsts.firebaseFirestore
                .collection(AppStrings.orders)
                .where('userId', isEqualTo: AppStrings.userId)
                .get();

        final List<OrderModel> orders = ordersResponse.docs
            .map((order) => OrderModel.fromJson(order.data()))
            .toList();

        emit(GetOrdersLoadedState(orders: orders));
      } catch (e) {
        print(e);
        emit(const GetOrdersErrorState(error: AppStrings.unexpectedException));
      }
    } else {
      emit(const GetOrdersErrorState(error: AppStrings.internetFaliureMessage));
    }
  }

  Future<void> cancelOrder({required String orderId}) async {
    emit(CancelOrderLoadingState());
    if (await AppConsts.internetConnection.isInternetConnected) {
      try {
        final ordersColection = FirebaseFirestore.instance.collection('Orders');

        DocumentSnapshot doc = await ordersColection
            .where('orderId', isEqualTo: orderId)
            .limit(1)
            .get()
            .then((querySnapshot) => querySnapshot.docs.first);

        DocumentReference docRef = doc.reference;

        docRef.update({'status': 'Canceled'});

        emit(CancelOrderLoadedState());
      } catch (e) {
        print(e);
        emit(
            const CancelOrderErrorState(error: AppStrings.unexpectedException));
      }
    } else {
      emit(const CancelOrderErrorState(
          error: AppStrings.internetFaliureMessage));
    }
  }
}
