import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery_app/core/chache_helper/chache_helper.dart';
import 'package:delivery_app/core/components/app_padding.dart';
import 'package:delivery_app/core/components/snack_bar.dart';
import 'package:delivery_app/core/components/space_boxes.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/core/utils/responsive.dart';
import 'package:delivery_app/featuers/payment/cubit/payment_cubit.dart';
import 'package:delivery_app/featuers/payment/presentation/widgets/lower_payment_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen(
      {super.key,
      required this.cartItems,
      required this.totalPrice,
      required this.lat,
      required this.lng});
  final List<Map<String, dynamic>> cartItems;
  final int totalPrice;
  final double lat;
  final double lng;
  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

final List<String> paymentMethods = [AppStrings.cash, AppStrings.card];

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  String currentOption = paymentMethods[0];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const AutoSizeText(AppStrings.paymentMethods),
        ),
        body: AppPadding(
            width: .02,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                height: Responsive.getHeight(context) - kToolbarHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: Responsive.getWidth(context),
                        height: Responsive.getHeight(context) * .05,
                        child: AutoSizeText(
                          AppStrings.selectPaymentMethods,
                          style: Theme.of(context).textTheme.headlineMedium,
                          maxLines: 1,
                        )),
                    const VerticalSpace(height: .01),
                    Container(
                      width: Responsive.getWidth(context),
                      height: Responsive.getHeight(context) * .10,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 231, 236, 240),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: AppPadding(
                        width: .02,
                        child: Row(
                          children: [
                            Image.asset(
                              AppStrings.cashIcon,
                              width: Responsive.getWidth(context) * .12,
                            ),
                            const HorizantalSpace(width: .05),
                            AutoSizeText(
                              AppStrings.cash,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const Spacer(),
                            Radio(
                                value: AppStrings.cash,
                                groupValue: currentOption,
                                onChanged: (value) {
                                  setState(() {
                                    currentOption = value!;
                                  });
                                })
                          ],
                        ),
                      ),
                    ),
                    const VerticalSpace(height: .01),
                    Container(
                      width: Responsive.getWidth(context),
                      height: Responsive.getHeight(context) * .10,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 231, 236, 240),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: AppPadding(
                        width: .01,
                        child: Row(
                          children: [
                            Image.asset(
                              AppStrings.visaIcon,
                              width: Responsive.getWidth(context) * .15,
                            ),
                            const HorizantalSpace(width: .05),
                            AutoSizeText(
                              AppStrings.card,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const Spacer(),
                            BlocConsumer<PaymentCubit, PaymentState>(
                                listener: (context, state) {
                              if (state is MakePaymentErrorState) {
                                showSnackBar(state.error, context, Colors.red);
                                setState(() {
                                  currentOption = paymentMethods[0];
                                });
                              }
                            }, builder: (context, state) {
                              final PaymentCubit paymentCubit =
                                  BlocProvider.of<PaymentCubit>(context);
                              return Radio(
                                  value: AppStrings.card,
                                  groupValue: currentOption,
                                  onChanged: (value) {
                                    setState(() {
                                      currentOption = value!;
                                    });
                                    paymentCubit.makePayment(
                                        widget.totalPrice, 'EGP');
                                  });
                            })
                          ],
                        ),
                      ),
                    ),
                    LowerPaymentWidget(
                        cartItems: widget.cartItems,
                        lat: widget.lat,
                        lng: widget.lng,
                        userName: CacheHelper.getString(key: 'userName') ?? '',
                        finalPrice: widget.totalPrice,
                        paymentMethod: currentOption,
                        paymentStatus: currentOption == AppStrings.cash
                            ? AppStrings.unpaid
                            : AppStrings.paid,
                        orderId: Random().nextInt(1000000).toString())
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
