import 'package:flutter/material.dart';
import 'package:rossoneri_store/src/constants/app_sizes.dart';
import 'package:rossoneri_store/src/features/products/domain/product_model.dart';

class ProductRating extends StatelessWidget {
  final Product product;

  const ProductRating({super.key, required this.product});
    

  @override
 Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        gapW8,
        Text(
          product.avgRating.toStringAsFixed(1),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        gapW8,
        Expanded(
          child: Text(
            product.numRatings == 1
                ? '1 rating'
                : '${product.numRatings.toString()} ratings',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}