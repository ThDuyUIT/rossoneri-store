import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rossoneri_store/src/common_widgets.dart/primary_button.dart';
import 'package:rossoneri_store/src/constants/app_colors.dart';
import 'package:rossoneri_store/src/constants/app_sizes.dart';
import 'package:rossoneri_store/src/features/cart/application/cart_service.dart';
import 'package:rossoneri_store/src/features/cart/presentation/add_to_cart/controller/add_to_cart_controller.dart';
import 'package:rossoneri_store/src/features/cart/presentation/add_to_cart/widget/item_quantity_selector.dart';
import 'package:rossoneri_store/src/features/products/domain/product_model.dart';

class AddToCart extends ConsumerWidget {
  final Product product;

  const AddToCart({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final availableQuantity = ref.watch(itemAvailableQuantityProvider(product));
    final state = ref.watch(addToCartControllerProvider);
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Quantity:',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    )),
            ItemQuantitySelector(
                quantity: state.value!,
                maxQuantity: min(availableQuantity, 10),
                onChanged: state.isLoading
                    ? null
                    : (quantity) {
                        ref
                            .read(addToCartControllerProvider.notifier)
                            .updateQuantity(quantity);
                      }),
          ],
        ),
        gapH8,
        const Divider(),
        gapH8,
        SizedBox(
          width: double.infinity,
          child: PrimaryButton(
              text: availableQuantity > 0 ? 'Add to Cart' : 'Out of Stock',
              backgroundColor: ColorApp.nero,
              foregroundColor: Colors.white,
              onPressed: availableQuantity > 0
                  ? () async {
                      await ref
                          .read(addToCartControllerProvider.notifier)
                          .addItems(product.productId);
                    }
                  : null 
              ),
        ),
      ],
    );
  }
}
