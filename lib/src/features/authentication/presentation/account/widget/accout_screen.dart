import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rossoneri_store/src/common_widgets.dart/edit_text_widget.dart';
import 'package:rossoneri_store/src/common_widgets.dart/input_text_widget.dart';
import 'package:rossoneri_store/src/common_widgets.dart/primary_button.dart';
import 'package:rossoneri_store/src/common_widgets.dart/responsive_center.dart';
import 'package:rossoneri_store/src/constants/app_colors.dart';
import 'package:rossoneri_store/src/constants/app_sizes.dart';
import 'package:rossoneri_store/src/features/authentication/data/auth_repository.dart';
import 'package:rossoneri_store/src/features/authentication/domain/user_model.dart';
import 'package:rossoneri_store/src/features/authentication/presentation/account/controller/account_screen_controller.dart';
import 'package:rossoneri_store/src/features/authentication/presentation/account/controller/account_state.dart';
import 'package:rossoneri_store/src/features/authentication/presentation/account/widget/profile_tab.dart';
import 'package:rossoneri_store/src/features/orders/presentation/order_screen.dart';
import 'package:rossoneri_store/src/routing/app_router.dart';

enum TypesTab { profile, orders }

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key, required this.typesTab}) : super(key: key);
  final TypesTab typesTab;

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int index;
  @override
  void initState() {
    index = widget.typesTab == TypesTab.profile ? 0 : 1;
    _tabController = TabController(length: 2, vsync: this);
    _tabController.index = index;
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  void _handleTabSelection() {
    setState(() {
      index = _tabController.index;
      if (index == 0) {
        context.go('/account:profile');
      }else{
        context.go('/account:orders');}

    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: ColorApp.nero,
        // foregroundColor: Colors.white,
        title: const Text('Account'),
      ),
      body: Container(
        padding: const EdgeInsets.all(Sizes.p12),
        child: ResponsiveCenter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TabBar(
                  labelColor: ColorApp.grey,
                  unselectedLabelColor: Colors.white,
                  controller: _tabController,
                  indicatorColor: Colors.transparent,
                  labelPadding: EdgeInsets.zero,
                  tabs: [
                    Tab(
                      child: Container(
                          width: double.infinity,
                          color: index == 0 ? ColorApp.rosso : Colors.white,
                          child: Center(
                              child: Text(
                            'Profile',
                            style: TextStyle(
                                color:
                                    index == 0 ? Colors.white : ColorApp.grey),
                          ))),
                    ),
                    Tab(
                      child: Container(
                          color: index == 1 ? ColorApp.rosso : Colors.white,
                          width: double.infinity,
                          child: Center(
                              child: Text(
                            'Orders',
                            style: TextStyle(
                                color:
                                    index == 1 ? Colors.white : ColorApp.grey),
                          ))),
                    ),
                  ]),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(top: Sizes.p24),
                        child: ProfileTab(),
                      ),
                    ),
                    OrderScreen()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
