import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_app/core/components/app_padding.dart';
import 'package:delivery_app/core/components/space_boxes.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/core/utils/responsive.dart';
import 'package:delivery_app/featuers/resturants/model/returant_model.dart';
import 'package:flutter/material.dart';

class MenuUpperWidget extends StatelessWidget {
  const MenuUpperWidget({super.key, required this.resturantModel});
  final ResturantModel resturantModel;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Responsive.getHeight(context) * .40,
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: resturantModel.image,
            errorWidget: (context, url, error) {
              return const Center(
                child: Icon(Icons.warning),
              );
            },
            width: double.infinity,
            height: Responsive.getHeight(context) * .30,
            fit: BoxFit.fill,
          ),
          Positioned(
            top: Responsive.getHeight(context) * .04,
            child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
          ),
          Positioned(
              top: Responsive.getHeight(context) * .25,
              left: Responsive.getWidth(context) * .10,
              right: Responsive.getWidth(context) * .10,
              child: Container(
                width: Responsive.getWidth(context) * .80,
                height: Responsive.getHeight(context) * .15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                    color: const Color.fromARGB(255, 255, 255, 255)),
                child: AppPadding(
                  width: .02,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: Responsive.getWidth(context) * .15,
                            height: Responsive.getHeight(context) * .06,
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      resturantModel.image),
                                  fit: BoxFit.fill,
                                )),
                          ),
                          const HorizantalSpace(width: .05),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                resturantModel.title,
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                                textScaleFactor:
                                    Responsive.getWidth(context) > 500
                                        ? 1.5
                                        : 1,
                                maxLines: 1,
                              ),
                              AutoSizeText(
                                resturantModel.category,
                                style: Theme.of(context).textTheme.bodySmall,
                                textScaleFactor:
                                    Responsive.getWidth(context) > 500
                                        ? 1.5
                                        : 1,
                                maxLines: 1,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  const HorizantalSpace(width: .01),
                                  AutoSizeText(
                                    resturantModel.rating,
                                    textScaleFactor:
                                        Responsive.getWidth(context) > 500
                                            ? 1.3
                                            : 1,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Column(
                            children: [
                              AutoSizeText(AppStrings.deliveryFee),
                              AutoSizeText('EGP 15')
                            ],
                          ),
                          const VerticalDivider(
                            width: 10,
                            thickness: 10,
                            color: Colors.black,
                          ),
                          Column(
                            children: [
                              const AutoSizeText(AppStrings.deliveryTime),
                              AutoSizeText(resturantModel.deliveryTime)
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
