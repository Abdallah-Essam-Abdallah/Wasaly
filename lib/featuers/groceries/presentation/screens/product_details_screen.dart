import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_app/core/components/addtocart_button.dart';
import 'package:delivery_app/core/components/app_padding.dart';
import 'package:delivery_app/core/components/space_boxes.dart';
import 'package:delivery_app/core/utils/responsive.dart';
import 'package:delivery_app/featuers/cart/cubit/cart_cubit.dart';
import 'package:delivery_app/featuers/groceries/presentation/widgets/product_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.description,
      required this.price,
      required this.model});
  final String image;
  final String title;
  final String description;
  final int price;
  final Map<String, dynamic> model;
  @override
  Widget build(BuildContext context) {
    final CartCubit cartCubit = BlocProvider.of<CartCubit>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topLeft,
              children: [
                CachedNetworkImage(
                  imageUrl: image,
                  height: Responsive.getHeight(context) * .40,
                  width: Responsive.getWidth(context),
                ),
                IconButton(
                    onPressed: () {
                      cartCubit.resetProductCount();
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back))
              ],
            ),
            const VerticalSpace(height: .02),
            Expanded(
                child: AppPadding(
              width: .02,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductDetailsWidget(
                      title: title, description: description, price: price),
                  const Spacer(),
                  Center(child: BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      return AddToCartButton(
                        cartItem: model,
                        quantity: cartCubit.productCount,
                        price: price * cartCubit.productCount,
                      );
                    },
                  )),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
