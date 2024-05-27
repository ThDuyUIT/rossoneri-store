import 'package:flutter/material.dart';
import 'package:rossoneri_store/src/constants/app_sizes.dart';
import 'package:rossoneri_store/src/features/cart/presentation/cart_total/widget/cart_total_text.dart';


class CartTotalWidget extends StatelessWidget {
  final WidgetBuilder ctaBuilder;

  const CartTotalWidget({super.key, required this.ctaBuilder});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const CartTotalText(),
        gapH8,
        ctaBuilder(context),
      ],
    );
  }
}
