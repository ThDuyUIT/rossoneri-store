import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rossoneri_store/src/common_widgets.dart/async_value_widget.dart';
import 'package:rossoneri_store/src/constants/app_sizes.dart';
import 'package:rossoneri_store/src/features/cart/domain/item_model.dart';
import 'package:rossoneri_store/src/features/products/data/products_repository.dart';
import 'package:rossoneri_store/src/features/products/domain/product_model.dart';

/// Shows an individual order item, including price and quantity.
class OrderItemListTile extends ConsumerWidget {
  const OrderItemListTile({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productValue = ref.watch(productProvider(item.productId));
    return AsyncValueWidget<Product?>(
      value: productValue,
      data: (product) => Padding(
        padding: const EdgeInsets.symmetric(vertical: Sizes.p8),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Flexible(flex: 2, child: Image.asset(product!.imageUrl)),
              gapW8,
              Flexible(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.title),
                    gapH12,
                    Text(
                      'Quantity: ${item.quantity}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                '\$ ${product.price}',
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
