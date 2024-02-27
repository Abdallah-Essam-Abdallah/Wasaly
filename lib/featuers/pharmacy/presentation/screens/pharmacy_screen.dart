import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery_app/core/components/app_padding.dart';
import 'package:delivery_app/core/components/snack_bar.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/featuers/pharmacy/cubit/pharmacy_cubit.dart';
import 'package:delivery_app/featuers/pharmacy/presentation/widgets/pharmacy_screen_initial.dart';
import 'package:delivery_app/featuers/pharmacy/presentation/widgets/prescription_uploaded_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PharmacyScreen extends StatelessWidget {
  const PharmacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PharmacyCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const AutoSizeText(AppStrings.pharmacy),
        ),
        body: AppPadding(
          width: .02,
          child: Center(
            child: BlocConsumer<PharmacyCubit, PharmacyState>(
              listener: (context, state) {
                if (state is UploadPrescriptionErrorState) {
                  showSnackBar(state.error, context, Colors.red);
                }
              },
              builder: (context, state) {
                if (state is PharmacyInitial) {
                  return const PharmacyScreenInitialWidget();
                } else if (state is UploadPrescriptionLoadingState) {
                  return const CircularProgressIndicator.adaptive();
                } else if (state is UploadPrescriptionLoadedState) {
                  return PrescriptionUploadedWidget(
                    image: state.image,
                  );
                } else {
                  return const PharmacyScreenInitialWidget();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
