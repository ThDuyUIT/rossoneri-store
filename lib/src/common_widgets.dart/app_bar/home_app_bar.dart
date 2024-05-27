import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rossoneri_store/src/common_widgets.dart/action_icon_button.dart';
import 'package:rossoneri_store/src/common_widgets.dart/app_bar/kinds_product_filter.dart';
import 'package:rossoneri_store/src/common_widgets.dart/app_bar/kinds_product_popup_menu.dart';
import 'package:rossoneri_store/src/common_widgets.dart/app_bar/shopping_cart_button.dart';
import 'package:rossoneri_store/src/common_widgets.dart/async_value_widget.dart';
import 'package:rossoneri_store/src/common_widgets.dart/name_app.dart';
import 'package:rossoneri_store/src/constants/app_colors.dart';
import 'package:rossoneri_store/src/constants/app_sizes.dart';
import 'package:rossoneri_store/src/constants/breakpoints.dart';
import 'package:rossoneri_store/src/features/authentication/data/auth_repository.dart';
import 'package:rossoneri_store/src/features/authentication/domain/user_model.dart';
import 'package:rossoneri_store/src/features/authentication/presentation/account/widget/accout_screen.dart';
import 'package:rossoneri_store/src/routing/app_router.dart';

class HomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final bool isTitle;
  final bool isPopUp;
  const HomeAppBar({super.key, this.isTitle = false, this.isPopUp = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return screenWidth < Breakpoint.desktop
        ? AppBar(
            backgroundColor: ColorApp.basic,
            centerTitle: true,
            leading: isPopUp == true ? const  KindsProductPopupMenu(): null,
            title: RichText(
                text: const TextSpan(children: <TextSpan>[
              TextSpan(
                  text: 'Rosso',
                  style: TextStyle(
                      color: ColorApp.rosso,
                      fontWeight: FontWeight.bold,
                      fontSize: Sizes.p24)),
              TextSpan(
                  text: 'neri',
                  style: TextStyle(
                      color: ColorApp.nero,
                      fontWeight: FontWeight.bold,
                      fontSize: Sizes.p24)),
              TextSpan(
                  text: ' Store',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                      fontSize: Sizes.p24)),
            ])),
            actions: [
              ShoppingCartButton(),
              ActionIconButton(
                icon: Icons.account_circle_outlined,
                onPressed: () async {
                  final auth = ref.watch(authRepositoryProvider);
                  auth.watchUser().listen((user) {
                    user == null
                        ? context.goNamed(AppRoute.signIn.name)
                        : context.goNamed(AppRoute.account.name, pathParameters: {'tab': TypesTab.profile.name});
                  });
                },
              ),
            ],
          )
        : AppBar(
            backgroundColor: ColorApp.basic,
            leadingWidth: isTitle ? 200 : null,
            leading: isTitle == true ? nameApp : null,
            centerTitle: !isTitle,
            title: isTitle ? const KindProductFilter() : nameApp,
            actions: [
              ShoppingCartButton(),
              ActionIconButton(
                icon: Icons.account_circle_outlined,
                onPressed: () async {
                  final auth = ref.watch(authRepositoryProvider);
                  auth.watchUser().listen((user) {
                    user == null
                        ? context.goNamed(AppRoute.signIn.name)
                        : context.goNamed(AppRoute.account.name, pathParameters: {'tab': TypesTab.profile.name});
                  });
                },
              ),
            ],
          );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(60.0);
}
