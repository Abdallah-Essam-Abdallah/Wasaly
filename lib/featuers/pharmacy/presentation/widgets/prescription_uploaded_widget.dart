import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_app/core/components/addtocart_button.dart';
import 'package:delivery_app/core/components/space_boxes.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/core/utils/responsive.dart';
import 'package:delivery_app/featuers/pharmacy/model/pharmacy_product_model.dart';
import 'package:flutter/material.dart';

class PrescriptionUploadedWidget extends StatelessWidget {
  const PrescriptionUploadedWidget({super.key, required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const VerticalSpace(height: .10),
        Container(
          width: Responsive.getWidth(context) * .80,
          height: Responsive.getHeight(context) * .50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(image: CachedNetworkImageProvider(image))),
        ),
        const VerticalSpace(height: .03),
        const AutoSizeText(
          '* ${AppStrings.pharmacyScreenNote}',
          style: TextStyle(color: Colors.red),
          maxLines: 2,
        ),
        const Spacer(),
        AddToCartButton(
            cartItem: PharmacyProductModel(prescriptionImage: image).toJson(),
            quantity: 1,
            price: 0)
      ],
    );
  }
}
