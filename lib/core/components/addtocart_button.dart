import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery_app/core/components/snack_bar.dart';

import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/core/utils/responsive.dart';
import 'package:delivery_app/featuers/cart/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton(
      {super.key,
      required this.cartItem,
      required this.quantity,
      required this.price});

  final Map<String, dynamic> cartItem;
  final int quantity;
  final int price;

  @override
  Widget build(BuildContext context) {
    final CartCubit cartCubit = BlocProvider.of<CartCubit>(context);
    return BlocConsumer<CartCubit, CartState>(listener: (context, state) {
      if (state is AddItemToCartLoadedState) {
        showSnackBar(AppStrings.cartSuccsesMessage, context, Colors.green);
      } else if (state is AddItemToCartLoadedState) {
        showSnackBar(AppStrings.unexpectedException, context, Colors.red);
      }
    }, builder: (context, state) {
      if (state is AddItemToCartLoadingState) {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      }
      return SizedBox(
          width: Responsive.getWidth(context) > 500
              ? Responsive.getWidth(context) * .30
              : Responsive.getWidth(context) * .50,
          height: Responsive.getHeight(context) * .05,
          child: ElevatedButton(
              onPressed: () async {
                await cartCubit.addItemToCart(
                    cartItem: cartItem, quantity: quantity, price: price);
                cartCubit.resetProductCount();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AutoSizeText(
                    AppStrings.addToCart,
                    style: const TextStyle(color: Colors.white),
                    textScaleFactor:
                        Responsive.getWidth(context) > 500 ? 1.5 : 1,
                  ),
                  const Icon(Icons.shopping_cart)
                ],
              )));
    });
  }
}
