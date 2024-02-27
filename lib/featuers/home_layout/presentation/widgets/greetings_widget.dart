import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery_app/core/chache_helper/chache_helper.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/core/utils/responsive.dart';
import 'package:delivery_app/featuers/profile/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class GreetingsWidget extends StatelessWidget {
  const GreetingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: Responsive.getHeight(context) * .07,
        width: Responsive.getWidth(context),
        child: Row(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              AutoSizeText(
                AppStrings.hello,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state is GetUserDataLoadingState &&
                      CacheHelper.getString(key: 'userName') == null) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[400]!,
                      highlightColor: Colors.grey[200]!,
                      child: Container(
                        height: Responsive.getHeight(context) * .01,
                        width: Responsive.getWidth(context) * .25,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    );
                  } else if (state is GetUserDataLoadedState &&
                      CacheHelper.getString(key: 'userName') == null) {
                    CacheHelper.setString(
                        key: 'userName', value: state.user.userName);
                    return Expanded(
                      child: AutoSizeText(
                        state.user.userName,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    );
                  } else if (CacheHelper.getString(key: 'userName') != null) {
                    return Expanded(
                      child: AutoSizeText(
                        CacheHelper.getString(key: 'userName')!,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ]),
            const Spacer(),
            Container(
              height: Responsive.getHeight(context) * .06,
              width: Responsive.getWidth(context) * .15,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromARGB(255, 61, 103, 109),
                  image: const DecorationImage(
                      image: AssetImage(AppStrings.profileImage))),
            )
          ],
        ));
  }
}
