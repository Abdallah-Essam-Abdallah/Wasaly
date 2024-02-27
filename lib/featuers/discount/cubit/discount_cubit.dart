import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/core/consts/app_consts.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/featuers/discount/model/coupon_model.dart';
import 'package:equatable/equatable.dart';
part 'discount_state.dart';

class DiscountCubit extends Cubit<DiscountState> {
  DiscountCubit() : super(DiscountInitial());

  int? priceAfterDiscount;

  void emitIntialState() {
    emit(DiscountInitial());
  }

  Future<void> validateCoupon(String couponCode, int finalPrice) async {
    if (await AppConsts.internetConnection.isInternetConnected) {
      try {
        emit(ValidateCouponLoadingState());
        final QuerySnapshot<Map<String, dynamic>> querySnapshot =
            await AppConsts.firebaseFirestore
                .collection('Coupons')
                .where('code', isEqualTo: couponCode)
                .get();

        if (querySnapshot.docs.isNotEmpty) {
          final DocumentSnapshot<Map<String, dynamic>> couponDoc =
              querySnapshot.docs.first;
          final CouponModel couponModel =
              CouponModel.fromJson(couponDoc.data()!);

          final Timestamp expirationTimestamp = couponDoc['expirationDate'];

          final DateTime expirationDate = expirationTimestamp.toDate();

          if (expirationDate.isAfter(DateTime.now())) {
            finalPrice = finalPrice - couponModel.value;
            priceAfterDiscount = finalPrice + 15;
            emit(ValidateCouponLoadedState(
                priceAfterDiscount: finalPrice,
                discountValue: couponModel.value));
          } else {
            emit(const ValidateCouponErrorState(
                error: AppStrings.expiredCoupon));
          }
        } else {
          emit(const ValidateCouponErrorState(error: AppStrings.invalidCoupon));
        }
      } catch (e) {
        print(e);
        emit(const ValidateCouponErrorState(error: AppStrings.invalidCoupon));
      }
    } else {
      emit(const ValidateCouponErrorState(
          error: AppStrings.internetFaliureMessage));
    }
  }

  /*querySnapshot.docs
            .map((cartItem) => CouponModel.fromJson(cartItem.data())).first;*/
  /*int applyDiscount( int finalPrice) {
    validateCoupon(couponDoc['code']).then((isValid) {
      if (isValid) {
        finalPrice = finalPrice - couponDoc['value'].;
        return finalPrice;
      }
    });
    return finalPrice;
  }*/
}
