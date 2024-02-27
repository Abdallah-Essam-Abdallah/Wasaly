import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery_app/core/components/app_padding.dart';
import 'package:delivery_app/core/components/space_boxes.dart';
import 'package:delivery_app/core/utils/responsive.dart';
import 'package:delivery_app/featuers/resturants/model/returant_model.dart';
import 'package:delivery_app/featuers/resturants/presentation/screens/menu_screen.dart';
import 'package:flutter/material.dart';

class ResturantsDetalsWidget extends StatelessWidget {
  const ResturantsDetalsWidget({super.key, required this.resturants});
  final List<ResturantModel> resturants;

  @override
  Widget build(BuildContext context) {
    return AppPadding(
      width: .02,
      child: ListView.separated(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => MenuScreen(
                              resturantModel: resturants[index],
                            ))));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  border: Border.all(
                      color: const Color.fromARGB(255, 214, 212, 212),
                      width: .5),
                ),
                child: AppPadding(
                  width: .01,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: Responsive.getWidth(context) * .10,
                        backgroundImage: CachedNetworkImageProvider(
                          resturants[index].image,
                        ),
                      ),
                      const HorizantalSpace(width: .02),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              resturants[index].title,
                              style: Theme.of(context).textTheme.headlineMedium,
                              maxLines: 1,
                              textScaleFactor:
                                  Responsive.getWidth(context) > 500 ? 1.5 : 1,
                            ),
                            AutoSizeText(
                              resturants[index].category,
                              style: Theme.of(context).textTheme.bodySmall,
                              maxLines: 1,
                              textScaleFactor:
                                  Responsive.getWidth(context) > 500 ? 1.5 : 1,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                const HorizantalSpace(width: .01),
                                AutoSizeText(
                                  resturants[index].rating,
                                  textScaleFactor:
                                      Responsive.getWidth(context) > 500
                                          ? 1.3
                                          : 1,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.timer),
                                const HorizantalSpace(width: .01),
                                AutoSizeText(
                                  resturants[index].deliveryTime,
                                  textScaleFactor:
                                      Responsive.getWidth(context) > 500
                                          ? 1.3
                                          : 1,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const VerticalSpace(height: .01);
          },
          itemCount: resturants.length),
    );
  }
}
