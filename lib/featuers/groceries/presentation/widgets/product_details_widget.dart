import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery_app/core/components/space_boxes.dart';
import 'package:delivery_app/core/utils/responsive.dart';
import 'package:delivery_app/featuers/cart/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsWidget extends StatelessWidget {
  const ProductDetailsWidget(
      {super.key,
      required this.title,
      required this.description,
      required this.price});
  final int price;
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    final CartCubit cartCubit = BlocProvider.of<CartCubit>(context);
    return Column(
      children: [
        AutoSizeText(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
          maxLines: 2,
        ),
        const VerticalSpace(height: .02),
        AutoSizeText(
          description,
          style: Theme.of(context).textTheme.bodySmall,
          textScaleFactor: Responsive.getWidth(context) > 500 ? 1.5 : 1,
          overflow: TextOverflow.visible,
          maxLines: 4,
        ),
        const VerticalSpace(height: .02),
        SizedBox(
          width: Responsive.getWidth(context),
          child: Row(
            children: [
              BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  return AutoSizeText(
                    '${price * cartCubit.productCount} EGP',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textScaleFactor:
                        Responsive.getWidth(context) > 500 ? 1.5 : 1,
                    maxLines: 1,
                  );
                },
              ),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    cartCubit.dicreaseProductCount();
                  },
                  child: const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 61, 103, 109),
                      foregroundColor: Color.fromARGB(255, 247, 244, 244),
                      child: Icon(Icons.remove))),
              const HorizantalSpace(width: .01),
              BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  return Text(
                    cartCubit.productCount.toString(),
                    style: Theme.of(context).textTheme.headlineMedium,
                    textScaleFactor: 1.5,
                  );
                },
              ),
              const HorizantalSpace(width: .01),
              TextButton(
                  onPressed: () {
                    cartCubit.increaseProductCount();
                  },
                  child: const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 61, 103, 109),
                      foregroundColor: Color.fromARGB(255, 247, 244, 244),
                      child: Icon(Icons.add))),
            ],
          ),
        ),
      ],
    );
  }
}
