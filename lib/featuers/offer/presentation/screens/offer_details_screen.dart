import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_app/core/components/addtocart_button.dart';
import 'package:delivery_app/core/components/app_padding.dart';
import 'package:delivery_app/core/components/space_boxes.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/core/utils/responsive.dart';
import 'package:delivery_app/featuers/offer/model/offer_model.dart';
import 'package:delivery_app/featuers/offer/presentation/widgets/offer_details_card.dart';
import 'package:flutter/material.dart';

class OfferDetailsScreen extends StatelessWidget {
  const OfferDetailsScreen({super.key, required this.offer});
  final OfferModel offer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                imageUrl: offer.image,
                errorWidget: (context, url, error) {
                  return const Center(
                    child: Icon(Icons.warning),
                  );
                },
                width: double.infinity,
                height: Responsive.getHeight(context) * .40,
                fit: BoxFit.fill,
              ),
              Positioned(
                top: Responsive.getHeight(context) * .03,
                child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
              )
            ],
          ),
          const VerticalSpace(height: .01),
          Expanded(
            child: AppPadding(
              width: .02,
              child: Column(
                children: [
                  Row(
                    children: [
                      AutoSizeText(
                        AppStrings.offerDetails,
                        textScaleFactor:
                            Responsive.getWidth(context) > 500 ? 1.5 : 1,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  const VerticalSpace(height: .01),
                  OfferDetailsCard(offer: offer),
                  const Spacer(),
                  AddToCartButton(
                    cartItem: offer.toJson(),
                    quantity: 1,
                    price: offer.priceAfterDiscount,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
