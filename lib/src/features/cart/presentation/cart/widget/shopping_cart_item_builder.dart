import 'package:flutter/material.dart';
import 'package:rossoneri_store/src/common_widgets.dart/decorated_box_with_shadow.dart';
import 'package:rossoneri_store/src/common_widgets.dart/empty_placeholder_widget.dart';
import 'package:rossoneri_store/src/common_widgets.dart/responsive_center.dart';
import 'package:rossoneri_store/src/constants/app_sizes.dart';
import 'package:rossoneri_store/src/constants/breakpoints.dart';
import 'package:rossoneri_store/src/features/cart/domain/item_model.dart';
import 'package:rossoneri_store/src/features/cart/presentation/cart/widget/shopping_cart_item.dart';
import 'package:rossoneri_store/src/features/cart/presentation/cart_total/widget/cart_total_widget.dart';
import 'package:rossoneri_store/src/features/checkout/presentation/widget/payment_page.dart';

/// Responsive widget showing the cart items and the checkout button
class ShoppingCartItemsBuilder extends StatelessWidget {
  const ShoppingCartItemsBuilder({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.ctaBuilder,
    this.isCircular = false,
  });
  final List<Item> items;
  final Widget Function(BuildContext, Item, int) itemBuilder;
  final WidgetBuilder? ctaBuilder;
  final bool isCircular;

  @override
  Widget build(BuildContext context) {
    if (isCircular && items.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // If there are no items, show a placeholder
    if (items.isEmpty) {
      return const EmptyPlaceholderWidget(
        message: 'Your shopping cart is empty',
      );
    }
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= Breakpoint.tablet) {
      return ResponsiveCenter(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
        child: Row(
          children: [
            Flexible(
              // use 3 flex units for the list of items
              flex: 3,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: Sizes.p16),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return itemBuilder(context, item, index);
                },
                itemCount: items.length,
              ),
            ),
            gapW16,
            ctaBuilder == null
                ? const SizedBox()
                : Flexible(
                    // use 1 flex unit for the checkout button
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: Sizes.p16),
                      child: CartTotalWidget(ctaBuilder: ctaBuilder!),
                    ),
                  )
          ],
        ),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(Sizes.p16),
              itemBuilder: (context, index) {
                final item = items[index];
                return itemBuilder(context, item, index);
              },
              itemCount: items.length,
            ),
          ),
          ctaBuilder == null
              ? const SizedBox()
              : DecoratedBoxWithShadow(
                  child: CartTotalWidget(ctaBuilder: ctaBuilder!),
                ),
        ],
      );
    }
  }
}
