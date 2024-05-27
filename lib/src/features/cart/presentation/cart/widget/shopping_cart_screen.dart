import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rossoneri_store/src/common_widgets.dart/async_value_widget.dart';
import 'package:rossoneri_store/src/common_widgets.dart/primary_button.dart';
import 'package:rossoneri_store/src/features/cart/application/cart_service.dart';
import 'package:rossoneri_store/src/features/cart/presentation/cart/controller/shopping_cart_sreen_controller.dart';
import 'package:rossoneri_store/src/features/cart/presentation/cart/widget/shopping_cart_item.dart';
import 'package:rossoneri_store/src/features/cart/presentation/cart/widget/shopping_cart_item_builder.dart';
import 'package:rossoneri_store/src/routing/app_router.dart';

class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Shopping Cart'),
        ),
        body: Consumer(builder: (context, ref, child) {
          final state = ref.watch(shoppingCartScreenControllerProvider);
          final cartValue = ref.watch(cartProvider);
          return AsyncValueWidget(
              value: cartValue,
              data: (cart) {
                return ShoppingCartItemsBuilder(
                  items: cart.toItemsList(),
                  itemBuilder: (context, item, index) {
                    return ShoppingCartItem(
                      isEditable: true,
                      item: item,
                      itemIndex: index,
                    );
                  },
                  ctaBuilder: (_) => state.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : PrimaryButton(
                          text: 'Checkout',
                          onPressed: () {
                            context.goNamed(AppRoute.checkout.name);
                          },
                        ),
                );
              });
        }));
  }
}
