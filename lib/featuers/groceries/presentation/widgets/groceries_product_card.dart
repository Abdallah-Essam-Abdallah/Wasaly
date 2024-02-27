import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_app/core/components/app_padding.dart';
import 'package:delivery_app/core/components/space_boxes.dart';
import 'package:delivery_app/core/utils/responsive.dart';
import 'package:delivery_app/featuers/cart/cubit/cart_cubit.dart';
import 'package:delivery_app/featuers/groceries/model/groceries_product_model.dart';
import 'package:delivery_app/featuers/groceries/presentation/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroceriesProductCard extends StatelessWidget {
  const GroceriesProductCard({super.key, required this.product});
  final GroceriesProductModel product;
  @override
  Widget build(BuildContext context) {
    final CartCubit cartCubit = BlocProvider.of<CartCubit>(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => ProductDetailsScreen(
                      image: product.image,
                      title: product.title,
                      description: product.description,
                      price: product.price,
                      model: product.toJson(),
                    ))));
      },
      child: Container(
        width: Responsive.getWidth(context) * .40,
        height: Responsive.getHeight(context) * .10,
        padding: EdgeInsets.all(Responsive.getWidth(context) * .02),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
              width: .8, color: const Color.fromARGB(255, 238, 235, 235)),
          color: Colors.white,
        ),
        child: AppPadding(
          width: .01,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: CachedNetworkImage(
                    width: double.infinity,
                    errorWidget: (context, url, error) {
                      return const Center(
                        child: Icon(Icons.error),
                      );
                    },
                    imageUrl: product.image),
              ),
              const VerticalSpace(height: .01),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(
                    '${product.price} EGP',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 61, 103, 109),
                    foregroundColor: const Color.fromARGB(255, 247, 244, 244),
                    child: IconButton(
                        onPressed: () {
                          cartCubit.addItemToCart(
                              cartItem: product.toJson(),
                              quantity: 1,
                              price: product.price);
                        },
                        icon: const Icon(Icons.add)),
                  ),
                ],
              ),
              const VerticalSpace(height: .01),
              Expanded(
                flex: 2,
                child: AutoSizeText(
                  product.title,
                  maxLines: 2,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.start,
                  textScaleFactor: 1.1,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
