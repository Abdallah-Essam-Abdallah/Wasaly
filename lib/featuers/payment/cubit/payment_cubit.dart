import 'package:bloc/bloc.dart';
import 'package:delivery_app/core/network/internet_connection.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/featuers/payment/patment_constants/payment_constants.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());
  final InternetConnection internetConnection = InternetConnection();

  Future<void> makePayment(int amount, String currency) async {
    if (await internetConnection.isInternetConnected) {
      emit(MakePaymentLoadingState());
      try {
        String clientSecret =
            await _getClientSecret((amount * 100).toString(), currency);
        await _initializePaymentSheet(clientSecret);
        emit(MakePaymentLoadedState());
        await Stripe.instance.presentPaymentSheet();
      } on StripeException catch (error) {
        print('error is:$error');
        emit(const MakePaymentErrorState(error: AppStrings.paymentFailed));
      }
    } else {
      emit(const MakePaymentErrorState(
          error: AppStrings.internetFaliureMessage));
    }
  }

  Future<void> _initializePaymentSheet(String clientSecret) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: "Abdallah",
      ),
    );
  }

  Future<String> _getClientSecret(String amount, String currency) async {
    Dio dio = Dio();
    var response = await dio.post(
      'https://api.stripe.com/v1/payment_intents',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${ApiKeys.secretKey}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
      ),
      data: {
        'amount': amount,
        'currency': currency,
      },
    );
    return response.data["client_secret"];
  }
}
