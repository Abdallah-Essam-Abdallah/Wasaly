import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery_app/core/components/app_padding.dart';
import 'package:delivery_app/core/components/space_boxes.dart';
import 'package:delivery_app/core/utils/responsive.dart';
import 'package:delivery_app/featuers/categories/models/categories_data.dart';
import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

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
                        builder: ((context) => categoriesScreens[index])));
              },
              child: Container(
                height: Responsive.getHeight(context) * .20,
                width: Responsive.getWidth(context),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                          categoriesData[index].image,
                        ))),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromARGB(64, 0, 0, 0),
                    )),
                    AutoSizeText(
                      categoriesData[index].title,
                      style: Theme.of(context).textTheme.labelLarge,
                      textScaleFactor:
                          Responsive.getWidth(context) > 500 ? 2.5 : 1.5,
                      maxLines: 1,
                    )
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const VerticalSpace(height: .01);
          },
          itemCount: categoriesData.length),
    ); /*SizedBox(
      height: Responsive.getHeight(context) * .50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VerticalSpace(height: .01),
          AutoSizeText(
            AppStrings.categories,
            style: Theme.of(context).textTheme.headlineMedium,
            textScaleFactor: Responsive.getWidth(context) > 500 ? 1.5 : 1,
            maxLines: 1,
          ),
          const VerticalSpace(height: .01),
          Expanded(
            child: GridView.builder(
                itemCount: categoriesData.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio:
                        Responsive.getWidth(context) > 500 ? 1.5 : 1,
                    mainAxisSpacing: Responsive.getHeight(context) * .01,
                    crossAxisSpacing: Responsive.getWidth(context) * .02,
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) =>
                                  categoriesScreens[index])));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                categoriesData[index].image,
                              ))),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color.fromARGB(64, 0, 0, 0),
                          )),
                          AutoSizeText(
                            categoriesData[index].title,
                            style: Theme.of(context).textTheme.labelLarge,
                            textScaleFactor:
                                Responsive.getWidth(context) > 500 ? 2.5 : 1.5,
                            maxLines: 1,
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );*/
  }
}
