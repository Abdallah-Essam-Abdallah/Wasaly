import 'package:auto_size_text/auto_size_text.dart';
import 'package:delivery_app/core/chache_helper/chache_helper.dart';
import 'package:delivery_app/core/components/app_padding.dart';
import 'package:delivery_app/core/components/space_boxes.dart';
import 'package:delivery_app/core/utils/appstrings.dart';
import 'package:delivery_app/core/utils/responsive.dart';
import 'package:delivery_app/featuers/authintecation/presentation/screens/login_screen.dart';
import 'package:delivery_app/featuers/cart/presentation/screens/cart_screen.dart';
import 'package:delivery_app/featuers/orders/presentation/screens/orders_screen.dart';
import 'package:delivery_app/featuers/profile/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileCubit profileCubit = BlocProvider.of<ProfileCubit>(context);
    return AppPadding(
      width: Responsive.getWidth(context) > 500 ? .10 : .02,
      child: Column(
        children: [
          const VerticalSpace(height: .01),
          Column(
            children: [
              CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 61, 103, 109),
                radius: Responsive.getWidth(context) * .20,
                backgroundImage: const AssetImage(
                  AppStrings.profileImage,
                ),
              ),
            ],
          ),
          const VerticalSpace(height: .01),
          AutoSizeText(
            CacheHelper.getString(key: 'userName') ?? '',
            style: Theme.of(context).textTheme.headlineMedium,
            maxLines: 1,
          ),
          const VerticalSpace(height: .01),
          AutoSizeText(
            profileCubit.user!.email,
            style: Theme.of(context).textTheme.headlineSmall,
            maxLines: 1,
          ),
          const VerticalSpace(height: .03),
          ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            tileColor: const Color.fromARGB(255, 206, 213, 221),
            title: const Text(AppStrings.cart),
            leading: const Icon(Icons.shopping_cart),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const CartScreen())));
            },
          ),
          const VerticalSpace(height: .01),
          ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            tileColor: const Color.fromARGB(255, 206, 213, 221),
            title: const Text(AppStrings.orders),
            leading: const Icon(Icons.shopping_bag),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const OrdersScreen())));
            },
          ),
          const VerticalSpace(height: .01),
          ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            tileColor: const Color.fromARGB(255, 206, 213, 221),
            title: const Text(
              AppStrings.signOut,
              style: TextStyle(color: Colors.red),
            ),
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            onTap: () {
              CacheHelper.setBoolean(key: 'isLoggedIn', value: false);

              CacheHelper.remove(key: 'userName');
              profileCubit.signOut();

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const LogInScreen())),
                  (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
