import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rossoneri_store/src/common_widgets.dart/primary_button.dart';
import 'package:rossoneri_store/src/constants/app_colors.dart';
import 'package:rossoneri_store/src/constants/app_sizes.dart';
import 'package:rossoneri_store/src/constants/breakpoints.dart';
import 'package:rossoneri_store/src/features/authentication/presentation/account/widget/accout_screen.dart';
import 'package:rossoneri_store/src/features/cart/application/cart_service.dart';
import 'package:rossoneri_store/src/features/checkout/presentation/controller/checkout_controller.dart';
import 'package:rossoneri_store/src/routing/app_router.dart';

class PaymentInformationContent extends ConsumerWidget {
  const PaymentInformationContent({Key? key}) : super(key: key);

  Future _confirm(WidgetRef ref) async {
    await ref.read(checkoutControllerProvider.notifier).checkOut();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cartItemsCount = ref.watch(cartItemsCountProvider);
    final totalItems = ref.watch(cartTotalProvider);
    final shippingFee = 10.00;
    final total = totalItems + shippingFee;
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(Sizes.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Order Summary',
              style: screenWidth >= Breakpoint.tablet
                  ? Theme.of(context).textTheme.titleLarge
                  : Theme.of(context).textTheme.titleMedium),
          gapH16,
          Row(
            children: [
              Expanded(child: Text('Subtotal($cartItemsCount items): ')),
              Expanded(
                  child: Text(
                '\$ $totalItems',
                textAlign: TextAlign.right,
              ))
            ],
          ),
          gapH12,
          Row(
            children: [
              Expanded(child: Text('Shipping: ')),
              Expanded(
                  child: Text(
                '\$ $shippingFee',
                textAlign: TextAlign.right,
              ))
            ],
          ),
          gapH12,
          const Divider(),
          gapH12,
          Row(
            children: [
              Expanded(
                  child: Text(
                'Total: ',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: ColorApp.rosso),
              )),
              Expanded(
                  child: Text(
                '\$ $total',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.right,
              ))
            ],
          ),
          gapH16,
          PrimaryButton(
              text: 'Confirm',
              onPressed: () async {
                await _confirm(ref);
                context.goNamed(AppRoute.account.name,
                    pathParameters: {'tab': TypesTab.orders.name});
              }),
          //CartTotalWidget(ctaBuilder: PrimaryButton(text: 'Pay', onPressed: () {})),
        ],
      ),
    ));
  }
}
