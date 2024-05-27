import 'package:flutter/material.dart';
import 'package:rossoneri_store/src/features/products/domain/product_model.dart';
import 'package:rossoneri_store/src/constants/app_sizes.dart';
import 'package:rossoneri_store/src/features/products/presentation/widget/detail_product/product_rating.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onPressed;

  const ProductCard({super.key, required this.product, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(product.imageUrl),
            gapH8,
            const Divider(),
            gapH8,
            Text(product.title, style: Theme.of(context).textTheme.titleMedium),
            //  if (product.numRatings >= 1) ...[
            //     gapH8,
            //     ProductAverageRating(product: product),
            //   ],
            if (product.numRatings >= 1) ...[
              gapH8,
              ProductRating(product: product),
            ],
            gapH8,
            Text(product.price.toString(),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
            gapH4,
            Text(
              product.availableQuantity <= 0
                  ? 'Out of Stock'
                  : 'Quantity: ${product.availableQuantity.toString()}',
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
      ),
    ));
  }
}
