import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_app/core/components/app_padding.dart';
import 'package:delivery_app/core/components/custom_dialog.dart';
import 'package:delivery_app/core/components/space_boxes.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/core/utils/responsive.dart';
import 'package:delivery_app/featuers/cart/cubit/cart_cubit.dart';
import 'package:delivery_app/featuers/cart/model/cart_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItemsWidget extends StatelessWidget {
  const CartItemsWidget({super.key, required this.cartItems});
  final List<CartItem> cartItems;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          final CartCubit cartCubit = BlocProvider.of<CartCubit>(context);
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: const Color.fromARGB(255, 214, 212, 212), width: .5),
              color: Colors.white,
            ),
            child: AppPadding(
              width: .02,
              child: Row(
                children: [
                  Container(
                      width: Responsive.getWidth(context) * .30,
                      height: Responsive.getHeight(context) * .15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(cartItems[index]
                                    .cartItem['image'] ??
                                cartItems[index].cartItem['prescriptionImage']),
                            fit: BoxFit.fill,
                          ))),
                  const HorizantalSpace(width: .03),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          cartItems[index].cartItem['title'] ??
                              AppStrings.pharmacyPrescription,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: Colors.black),
                          maxLines: 2,
                        ),
                        const VerticalSpace(height: .03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(
                              'x ${cartItems[index].quantity}',
                              style: Theme.of(context).textTheme.bodySmall,
                              textScaleFactor:
                                  Responsive.getWidth(context) > 500 ? 1.5 : 1,
                            ),
                            Row(
                              children: [
                                AutoSizeText(
                                  '\$ ${cartItems[index].price}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                                IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return CustomDialog(
                                                content: AppStrings
                                                    .removeDialogContent,
                                                title: AppStrings.remove,
                                                buttonTitle: AppStrings.remove,
                                                function: () {
                                                  cartCubit.deleteCartItem(
                                                      index: index);

                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop();
                                                });
                                          });
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ))
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const VerticalSpace(height: .01);
        },
        itemCount: cartItems.length);
  }
}
