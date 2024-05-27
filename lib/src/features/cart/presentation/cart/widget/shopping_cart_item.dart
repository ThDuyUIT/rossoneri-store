import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rossoneri_store/src/common_widgets.dart/async_value_widget.dart';
import 'package:rossoneri_store/src/common_widgets.dart/responsive_two_column_layout.dart';
import 'package:rossoneri_store/src/constants/app_sizes.dart';
import 'package:rossoneri_store/src/constants/breakpoints.dart';
import 'package:rossoneri_store/src/features/cart/domain/item_model.dart';
import 'package:rossoneri_store/src/features/cart/presentation/add_to_cart/widget/item_quantity_selector.dart';
import 'package:rossoneri_store/src/features/cart/presentation/cart/controller/shopping_cart_sreen_controller.dart';
import 'package:rossoneri_store/src/features/products/domain/product_model.dart';

import '../../../../products/data/products_repository.dart';

class ShoppingCartItem extends ConsumerWidget {
  final Item item;
  final int itemIndex;
  final bool isEditable;
  static double itemHeight = 0;

  const ShoppingCartItem(
      {Key? key,
      required this.item,
      required this.itemIndex,
      required this.isEditable})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productValue = ref.watch(productProvider(item.productId));
    ShoppingCartItem.itemHeight = MediaQuery.of(context).size.height;
    return AsyncValueWidget<Product>(
      value: productValue,
      data: (product) => Padding(
          padding: const EdgeInsets.all(Sizes.p4),
          child: Card(
            child: ShoppingCartContent(
              product: product,
              item: item,
              itemIndex: itemIndex,
              isEditable: isEditable,
            ),
          )),
    );
  }
}

class ShoppingCartContent extends StatelessWidget {
  final Product product;
  final Item item;
  final int itemIndex;
  final bool isEditable;

  const ShoppingCartContent(
      {Key? key,
      required this.isEditable,
      required this.product,
      required this.item,
      required this.itemIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    //ShoppingCartItem.itemHeight = MediaQuery.of(context).size.height;
    return ResponsiveTwoColumnLayout(
      spacing: Sizes.p24,
      endFlex: 2,
      breakpoint: 320,
      startContent: Image.asset(product.imageUrl),
      endContent: Padding(
        padding: const EdgeInsets.all(Sizes.p12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              product.title,
              style: screenWidth >= Breakpoint.tablet
                  ? Theme.of(context).textTheme.titleLarge
                  : Theme.of(context).textTheme.titleMedium,
            ),
            screenWidth >= Breakpoint.tablet ? gapH24 : gapH16,
            Text(
              product.price.toString(),
              style: screenWidth >= Breakpoint.tablet
                  ? Theme.of(context).textTheme.titleLarge
                  : Theme.of(context).textTheme.titleMedium,
            ),
            screenWidth >= Breakpoint.tablet ? gapH24 : gapH16,
            isEditable
                ? EditItemWidget(
                    availableQuantity: product.availableQuantity,
                    item: item,
                    itemIndex: itemIndex,
                  )
                : Padding(
                    padding: const EdgeInsets.all(Sizes.p8),
                    child: Text('Quantity: ${item.quantity}'))
          ],
        ),
      ),
    );
  }
}

class EditItemWidget extends ConsumerWidget {
  final int availableQuantity;
  final Item item;
  final int itemIndex;

  const EditItemWidget(
      {Key? key,
      required this.availableQuantity,
      required this.item,
      required this.itemIndex})
      : super(key: key);

  @override
  Widget build(Object context, WidgetRef ref) {
    final state = ref.watch(shoppingCartScreenControllerProvider);
    return Row(
      children: [
        ItemQuantitySelector(
            quantity: item.quantity,
            maxQuantity: availableQuantity,
            itemIndex: itemIndex,
            onChanged: state.isLoading
                ? null
                : (quantity) => ref
                    .watch(shoppingCartScreenControllerProvider.notifier)
                    .updateItemQuantity(item.productId, quantity)),
        IconButton(
            onPressed: state.isLoading
                ? null
                : () => ref
                    .watch(shoppingCartScreenControllerProvider.notifier)
                    .removeItem(item.productId),
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            )),
        const Spacer(),
      ],
    );
  }
}
