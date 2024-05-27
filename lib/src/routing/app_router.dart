import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rossoneri_store/src/features/authentication/presentation/account/widget/accout_screen.dart';
import 'package:rossoneri_store/src/features/authentication/presentation/sign_in/controller/sign_in_state.dart';
import 'package:rossoneri_store/src/features/authentication/presentation/sign_in/widget/sign_in_screen.dart';
import 'package:rossoneri_store/src/features/cart/presentation/cart/widget/shopping_cart_screen.dart';
import 'package:rossoneri_store/src/features/checkout/presentation/widget/checkout_screen.dart';
import 'package:rossoneri_store/src/features/orders/presentation/order_screen.dart';
import 'package:rossoneri_store/src/features/products/presentation/widget/detail_product/product_screen.dart';
import 'package:rossoneri_store/src/features/products/presentation/widget/product_list/products_list_screen.dart';

enum AppRoute {
  home,
  product,
  leaveReview,
  cart,
  checkout,
  orders,
  account,
  signIn,
}

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
        path: '/',
        name: AppRoute.home.name,
        pageBuilder: (context, state) => const MaterialPage(
            fullscreenDialog: true, child: ProductListScreen()),
        routes: [
          GoRoute(
              path: 'account:tab',
              name: AppRoute.account.name,
              pageBuilder: (context, state) {
                final typesTab = state.pathParameters['tab'] == 'orders'
                    ? TypesTab.orders
                    : TypesTab.profile;
                return MaterialPage(
                    child: AccountScreen(
                      typesTab: typesTab,
                    ),
                    fullscreenDialog: true);
              }),
          GoRoute(
            path: 'signIn',
            name: AppRoute.signIn.name,
            pageBuilder: (context, state) => const MaterialPage(
                child: SignInScreen(AuthenticationFormType.signIn),
                fullscreenDialog: true),
          ),
          GoRoute(
              path: 'product/:id',
              name: AppRoute.product.name,
              builder: (context, state) {
                final productId = state.pathParameters['id']!;
                return ProductScreen(productId: productId);
              }),
          GoRoute(
              path: 'cart',
              name: AppRoute.cart.name,
              pageBuilder: (context, state) => const MaterialPage(
                  child: ShoppingCartScreen(), fullscreenDialog: true)),
          GoRoute(
              path: 'checkout',
              name: AppRoute.checkout.name,
              pageBuilder: (context, state) => const MaterialPage(
                  child: CheckoutScreen(), fullscreenDialog: true)),
          GoRoute(
              path: 'orders',
              name: AppRoute.orders.name,
              pageBuilder: (context, state) => const MaterialPage(
                  child: OrderScreen(), fullscreenDialog: true)),
        ]),
  ],
);
