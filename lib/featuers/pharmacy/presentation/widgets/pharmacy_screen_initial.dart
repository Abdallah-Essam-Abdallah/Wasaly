import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery_app/core/components/space_boxes.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/core/utils/responsive.dart';
import 'package:delivery_app/featuers/pharmacy/cubit/pharmacy_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PharmacyScreenInitialWidget extends StatelessWidget {
  const PharmacyScreenInitialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final PharmacyCubit pharmacyCubit = BlocProvider.of<PharmacyCubit>(context);
    return Column(
      children: [
        const VerticalSpace(height: .10),
        AutoSizeText(
          AppStrings.uploadPrescription,
          style: Theme.of(context).textTheme.headlineMedium,
          maxLines: 1,
        ),
        const VerticalSpace(height: .03),
        InkWell(
          onTap: () {
            pharmacyCubit.uploadPrescription();
          },
          child: Container(
            width: Responsive.getWidth(context) * .80,
            height: Responsive.getHeight(context) * .50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), border: Border.all()),
            child: const Center(
              child: AutoSizeText(
                AppStrings.uploadPrescription,
                maxLines: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
