import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_app/core/components/space_boxes.dart';
import 'package:delivery_app/core/utils/responsive.dart';
import 'package:delivery_app/featuers/offer/model/offer_model.dart';
import 'package:flutter/material.dart';

class OfferDetailsCard extends StatelessWidget {
  const OfferDetailsCard({super.key, required this.offer});
  final OfferModel offer;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 40,
      shadowColor: const Color.fromARGB(255, 231, 141, 88),
      child: Padding(
        padding: EdgeInsets.only(
          right: Responsive.getWidth(context) * .02,
          left: Responsive.getWidth(context) * .02,
          top: Responsive.getWidth(context) * .01,
          bottom: Responsive.getWidth(context) * .01,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    offer.title,
                    style: Theme.of(context).textTheme.headlineMedium,
                    textScaleFactor:
                        Responsive.getWidth(context) > 500 ? 1.5 : 1,
                    maxLines: 1,
                  ),
                  const VerticalSpace(height: .01),
                  AutoSizeText(
                    offer.description,
                    style: Theme.of(context).textTheme.bodySmall,
                    textScaleFactor:
                        Responsive.getWidth(context) > 500 ? 1.5 : 1,
                    maxLines: 2,
                  ),
                  const VerticalSpace(height: .03),
                  Row(
                    children: [
                      const Icon(Icons.discount),
                      const HorizantalSpace(width: .01),
                      AutoSizeText(
                        offer.priceAfterDiscount.toString(),
                        textScaleFactor:
                            Responsive.getWidth(context) > 500 ? 1.5 : 1,
                      ),
                      const HorizantalSpace(width: .01),
                      AutoSizeText.rich(
                        TextSpan(
                            text: offer.price.toString(),
                            style: const TextStyle(
                                decoration: TextDecoration.lineThrough)),
                        style: Theme.of(context).textTheme.bodySmall,
                        textScaleFactor:
                            Responsive.getWidth(context) > 500 ? 1.5 : 1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: Responsive.getHeight(context) * .15,
              width: Responsive.getWidth(context) * .30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: CachedNetworkImageProvider(
                      offer.image,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
