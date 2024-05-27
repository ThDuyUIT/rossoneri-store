import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rossoneri_store/src/common_widgets.dart/async_value_widget.dart';
import 'package:rossoneri_store/src/features/cart/application/cart_service.dart';
import 'package:rossoneri_store/src/features/cart/domain/cart_model.dart';
import 'package:rossoneri_store/src/features/cart/presentation/cart/widget/shopping_cart_item.dart';
import 'package:rossoneri_store/src/features/cart/presentation/cart/widget/shopping_cart_item_builder.dart';

class OrderInformationContent extends ConsumerWidget {
  const OrderInformationContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartValue = ref.watch(cartProvider);
    return AsyncValueWidget<Cart>(
      value: cartValue,
      data: (cart) {
        // return Column(
        //   children: [
        //     for (final item in cart.toItemsList())
        //       ShoppingCartItem(
        //         isEditable: false,
        //         item: item,
        //         itemIndex: cart.toItemsList().indexOf(item),
        //       ),
        //   ],
        // );
        return ShoppingCartItemsBuilder(
          items: cart.toItemsList(),
          itemBuilder: (_, item, index) => ShoppingCartItem(
            isEditable: false,
            item: item,
            itemIndex: index,
          ),
          ctaBuilder: null,
          isCircular: true,
        );
      },
    );
  }
}
