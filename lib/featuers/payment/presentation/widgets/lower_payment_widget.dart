import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery_app/core/components/snack_bar.dart';
import 'package:delivery_app/core/components/space_boxes.dart';
import 'package:delivery_app/core/components/text_form_field.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/core/utils/responsive.dart';
import 'package:delivery_app/featuers/cart/cubit/cart_cubit.dart';
import 'package:delivery_app/featuers/home_layout/presentation/screens/home_layout.dart';
import 'package:delivery_app/featuers/orders/cubit/orders_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LowerPaymentWidget extends StatefulWidget {
  const LowerPaymentWidget(
      {super.key,
      required this.cartItems,
      required this.lat,
      required this.lng,
      required this.userName,
      required this.finalPrice,
      required this.paymentMethod,
      required this.paymentStatus,
      required this.orderId});
  final List<Map<String, dynamic>> cartItems;
  final double lat;
  final double lng;
  final String userName;
  final int finalPrice;
  final String paymentMethod;
  final String paymentStatus;
  final String orderId;

  @override
  State<LowerPaymentWidget> createState() => _LowerPaymentWidgetState();
}

class _LowerPaymentWidgetState extends State<LowerPaymentWidget> {
  final TextEditingController noteController = TextEditingController();

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final OrdersCubit ordersCubit = BlocProvider.of<OrdersCubit>(context);
    final CartCubit cartCubit = BlocProvider.of<CartCubit>(context);
    return BlocConsumer<OrdersCubit, OrdersState>(
      listener: (context, state) {
        if (state is PlaceOrderErrorState) {
          showSnackBar(state.error, context, Colors.red);
        } else if (state is PlaceOrderLoadedState) {
          showAdaptiveDialog(
              context: context,
              builder: (context) {
                return AlertDialog.adaptive(
                  icon: Icon(
                    Icons.check_circle,
                    size: Responsive.getWidth(context) * .15,
                  ),
                  iconColor: Colors.green,
                  title: const Text(AppStrings.success),
                  content: const Text(AppStrings.paymentConfirmation),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const HomeLayout())),
                            (route) => false),
                        child: const Text(
                          AppStrings.close,
                        )),
                  ],
                );
              });
        }
      },
      builder: (context, state) {
        if (state is PlaceOrderLoadingState) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        return SizedBox(
          height: Responsive.getHeight(context) * .55,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VerticalSpace(height: .01),
              AutoSizeText(
                AppStrings.addNote,
                style: Theme.of(context).textTheme.headlineMedium,
                maxLines: 1,
              ),
              const VerticalSpace(height: .01),
              AppTextFormField(
                hintText: AppStrings.addNote,
                obscureText: false,
                keyboardType: TextInputType.text,
                maxLines: 5,
                controller: noteController,
              ),
              const Spacer(),
              Center(
                child: SizedBox(
                  width: Responsive.getWidth(context) > 500
                      ? Responsive.getWidth(context) * .30
                      : Responsive.getWidth(context) * .50,
                  height: Responsive.getHeight(context) * .05,
                  child: ElevatedButton(
                      onPressed: () {
                        ordersCubit.placeOrder(
                            cartItems: widget.cartItems,
                            finalPrice: widget.finalPrice,
                            lat: widget.lat,
                            lng: widget.lng,
                            userName: widget.userName,
                            paymentMethod: widget.paymentMethod,
                            paymentStatus: widget.paymentStatus,
                            orderId: widget.orderId,
                            note: noteController.text);
                        cartCubit.clearCart();
                      },
                      child: AutoSizeText(
                        AppStrings.placeOrder,
                        textScaleFactor:
                            Responsive.getWidth(context) > 500 ? 1.5 : 1,
                      )),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
