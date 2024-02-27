import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery_app/core/components/error_widget.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/featuers/resturants/cubit/resturants_cubit.dart';
import 'package:delivery_app/featuers/resturants/presentation/widgets/resturants_details_widget.dart';
import 'package:delivery_app/featuers/resturants/presentation/widgets/resturants_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResturantsScreen extends StatelessWidget {
  const ResturantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: ResturantsCubit()..getResturants(),
      child: Scaffold(
        appBar: AppBar(
          title: const AutoSizeText(AppStrings.resturants),
        ),
        body: BlocBuilder<ResturantsCubit, ResturantsState>(
          builder: (context, state) {
            if (state is GetResturantsLoadingState) {
              return const ResturantsLoadingWidget();
            } else if (state is GetResturantsLoadedState) {
              return ResturantsDetalsWidget(
                resturants: state.resturants,
              );
            } else {
              return const AppErrorWidget();
            }
          },
        ),
      ),
    );
  }
}
