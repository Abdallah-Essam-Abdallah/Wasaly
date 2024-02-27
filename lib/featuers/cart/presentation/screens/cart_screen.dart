import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery_app/core/components/app_padding.dart';
import 'package:delivery_app/core/components/error_widget.dart';
import 'package:delivery_app/core/components/space_boxes.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/core/utils/responsive.dart';
import 'package:delivery_app/featuers/cart/cubit/cart_cubit.dart';
import 'package:delivery_app/featuers/cart/presentation/widgets/cart_items_widget.dart';
import 'package:delivery_app/featuers/cart/presentation/widgets/cart_loading_widget.dart';
import 'package:delivery_app/featuers/cart/presentation/widgets/cart_price_widget.dart';
import 'package:delivery_app/featuers/cart/presentation/widgets/empty_cart_widgrt.dart';
import 'package:delivery_app/featuers/discount/cubit/discount_cubit.dart';
import 'package:delivery_app/featuers/location/presentation/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartCubit cartCubit = BlocProvider.of<CartCubit>(context);
    final DiscountCubit discountCubit = BlocProvider.of<DiscountCubit>(context);
    return BlocProvider.value(
      value: CartCubit()..getCartItems(),
      child: Scaffold(
        appBar: AppBar(
          title: const AutoSizeText(AppStrings.cart),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                discountCubit.emitIntialState();
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: BlocBuilder<CartCubit, CartState>(
          buildWhen: (previous, current) {
            return current is GetCartItemsLoadedState ||
                current is GetCartItemsLoadingState;
          },
          builder: (context, state) {
            if (state is GetCartItemsLoadingState) {
              return const CartLoadingWidget();
            } else if (state is GetCartItemsLoadedState) {
              if (state.cartItems.isEmpty) {
                return const EmptyCart();
              } else {
                return SingleChildScrollView(
                  child: AppPadding(
                    width: .02,
                    child: SizedBox(
                      height: Responsive.getHeight(context) -
                          Responsive.getHeight(context) * .15,
                      child: Column(
                        children: [
                          SizedBox(
                              height: Responsive.getHeight(context) * .60,
                              child: CartItemsWidget(
                                cartItems: state.cartItems,
                              )),
                          const VerticalSpace(height: .01),
                          CartPriceWidget(cartItems: state.cartItems),
                          const Spacer(),
                          SizedBox(
                            width: Responsive.getWidth(context) > 500
                                ? Responsive.getWidth(context) * .30
                                : Responsive.getWidth(context) * .50,
                            height: Responsive.getHeight(context) * .05,
                            child: ElevatedButton(
                                onPressed: () {
                                  discountCubit.emitIntialState();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => MapScreen(
                                                cartItems: state.cartItems
                                                    .map((cartItem) =>
                                                        cartItem.toJson())
                                                    .toList(),
                                                totalPrice: discountCubit
                                                        .priceAfterDiscount ??
                                                    cartCubit.getTotalPrice(
                                                            cartItems: state
                                                                .cartItems) +
                                                        15,
                                              ))));
                                },
                                child: AutoSizeText(
                                  AppStrings.checkout,
                                  textScaleFactor:
                                      Responsive.getWidth(context) > 500
                                          ? 1.5
                                          : 1,
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
            } else {
              return const AppErrorWidget();
            }
          },
        ),
      ),
    );
  }
}
