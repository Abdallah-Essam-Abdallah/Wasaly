import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery_app/core/components/snack_bar.dart';
import 'package:delivery_app/core/components/space_boxes.dart';
import 'package:delivery_app/core/components/text_form_field.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/featuers/cart/cubit/cart_cubit.dart';
import 'package:delivery_app/featuers/cart/model/cart_item_model.dart';
import 'package:delivery_app/featuers/discount/cubit/discount_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPriceWidget extends StatefulWidget {
  const CartPriceWidget({super.key, required this.cartItems});
  final List<CartItem> cartItems;

  @override
  State<CartPriceWidget> createState() => _CartPriceWidgetState();
}

class _CartPriceWidgetState extends State<CartPriceWidget> {
  final TextEditingController couponController = TextEditingController();

  @override
  void dispose() {
    couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CartCubit cartCubit = BlocProvider.of<CartCubit>(context);
    final DiscountCubit discountCubit = BlocProvider.of<DiscountCubit>(context);
    return BlocListener<DiscountCubit, DiscountState>(
      listener: (context, state) {
        if (state is ValidateCouponErrorState) {
          showSnackBar(
              state.error, context, const Color.fromARGB(255, 116, 11, 4));
        } else if (state is ValidateCouponLoadedState) {
          showSnackBar(AppStrings.couponSuccess, context, Colors.teal);
        }
      },
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: AppTextFormField(
                  hintText: AppStrings.addCoupon,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  controller: couponController,
                ),
              ),
              const HorizantalSpace(width: .01),
              Expanded(
                child: ElevatedButton(
                    onPressed: () => discountCubit.validateCoupon(
                        couponController.value.text,
                        cartCubit.getTotalPrice(cartItems: widget.cartItems)),
                    child: const AutoSizeText(
                      AppStrings.apply,
                      textScaleFactor: 1.5,
                    )),
              )
            ],
          ),
          const VerticalSpace(height: .01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(
                AppStrings.price,
                style: Theme.of(context).textTheme.headlineSmall,
                textScaleFactor: .75,
              ),
              BlocBuilder<DiscountCubit, DiscountState>(
                buildWhen: (previous, current) {
                  return previous is ValidateCouponLoadingState;
                },
                builder: (context, state) {
                  if (state is ValidateCouponLoadedState) {
                    return Row(
                      children: [
                        AutoSizeText(
                          '-${state.discountValue}EGP',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.red),
                          textScaleFactor: .70,
                        ),
                        const HorizantalSpace(width: .02),
                        AutoSizeText(
                          '${state.priceAfterDiscount} EGP',
                          style: Theme.of(context).textTheme.headlineSmall,
                          textScaleFactor: .75,
                        ),
                      ],
                    );
                  } else {
                    return AutoSizeText(
                      '${cartCubit.getTotalPrice(cartItems: widget.cartItems)} EGP',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textScaleFactor: .75,
                    );
                  }
                },
              )
            ],
          ),
          const VerticalSpace(height: .005),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(
                AppStrings.deliveryFess,
                style: Theme.of(context).textTheme.headlineSmall,
                textScaleFactor: .75,
              ),
              AutoSizeText(
                '15 EGP',
                style: Theme.of(context).textTheme.headlineSmall,
                textScaleFactor: .75,
              )
            ],
          ),
          const VerticalSpace(height: .005),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(
                AppStrings.totalPrice,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              BlocBuilder<DiscountCubit, DiscountState>(
                buildWhen: (previous, current) {
                  return previous is ValidateCouponLoadingState;
                },
                builder: (context, state) {
                  if (state is ValidateCouponLoadedState) {
                    return Row(
                      children: [
                        AutoSizeText(
                          '-${state.discountValue}EGP',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.red),
                          textScaleFactor: .70,
                        ),
                        const HorizantalSpace(width: .02),
                        AutoSizeText(
                          '${state.priceAfterDiscount + 15} EGP',
                          style: Theme.of(context).textTheme.headlineSmall,
                          textScaleFactor: .75,
                        ),
                      ],
                    );
                  } else {
                    return AutoSizeText(
                      '${cartCubit.getTotalPrice(cartItems: widget.cartItems) + 15} EGP',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textScaleFactor: .75,
                    );
                  }
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
