import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rossoneri_store/src/common_widgets.dart/app_bar/home_app_bar.dart';
import 'package:rossoneri_store/src/common_widgets.dart/async_value_widget.dart';
import 'package:rossoneri_store/src/constants/app_sizes.dart';
import 'package:rossoneri_store/src/common_widgets.dart/responsive_two_column_layout.dart';
import 'package:rossoneri_store/src/features/cart/presentation/add_to_cart/widget/add_to_cart_widget.dart';

import 'package:rossoneri_store/src/features/products/data/products_repository.dart';
import 'package:rossoneri_store/src/features/products/domain/product_model.dart';
import 'package:rossoneri_store/src/features/products/presentation/widget/detail_product/product_rating.dart';

class ProductScreen extends StatelessWidget {
  final String productId;

  const ProductScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(
        isTitle: false,
        isPopUp: false,
      ),
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, _) {
          final productValue = ref.watch(productProvider(productId));

          return AsyncValueWidget<Product>(
            value: productValue,
            data: (product) {
              return SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.all(Sizes.p8),
                child: ProductDetails(product: product),
              ));
            },
          );
        },
      ),
    );
  }
}

class ProductDetails extends StatelessWidget {
  final Product product;

  const ProductDetails({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return ResponsiveTwoColumnLayout(
      startContent: Card(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Image(image: AssetImage(product.imageUrl!)),
        ),
      ),
      spacing: Sizes.p16,
      endContent: Card(
          child: Padding(
              padding: const EdgeInsets.all(Sizes.p16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    product.title!,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  gapH8,
                  Text('Description',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          )),
                  gapH8,
                  Text(
                    product.description!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  if (product.numRatings > 0) ...[
                    gapH16,
                    const Divider(),
                    gapH8,
                    ProductRating(product: product)
                  ],
                  gapH8,
                  const Divider(),
                  gapH8,
                  Text(product.price.toString(),
                      style: Theme.of(context).textTheme.headlineSmall),
                  const Divider(),
                  gapH8,
                  AddToCart(product: product),
                ],
              ))),
    );
  }
}
