import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rossoneri_store/src/common_widgets.dart/empty_placeholder_widget.dart';
import 'package:rossoneri_store/src/common_widgets.dart/responsive_two_column_layout.dart';
import 'package:rossoneri_store/src/constants/app_sizes.dart';
import 'package:rossoneri_store/src/constants/breakpoints.dart';
import 'package:rossoneri_store/src/features/cart/application/cart_service.dart';
import 'package:rossoneri_store/src/features/cart/presentation/cart/widget/shopping_cart_item.dart';
import 'package:rossoneri_store/src/features/checkout/presentation/widget/delivery_information_content.dart';
import 'package:rossoneri_store/src/features/checkout/presentation/widget/order_information_content.dart';
import 'package:rossoneri_store/src/features/checkout/presentation/widget/pagement_information_content.dart';

class PaymentPage extends ConsumerWidget {
  const PaymentPage({Key? key}) : super(key: key);
  static double screenHeight = 0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final countItems = ref.watch(cartItemsCountProvider);
    double heightPage = (screenHeight + 135 * countItems);
    Future.delayed(Duration.zero, () {
      PaymentPage.screenHeight = heightPage;
    });
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: SingleChildScrollView(
        child: SizedBox(
          height: heightPage > 0
              ? heightPage
              : screenHeight, // Provide a default value in case it's less than or equal to 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ResponsiveTwoColumnLayout(
                startFlex: 1,
                endFlex: 1,
                startContent: const DeliveryInformationContent(),
                endContent: screenWidth >= Breakpoint.tablet
                    ? const Padding(
                        padding: EdgeInsets.all(Sizes.p16),
                        child: PaymentInformationContent(),
                      )
                    : const SizedBox(),
                spacing: 0,
              ),
              screenWidth >= Breakpoint.tablet
                  ? Flexible(
                      child: Row(
                      children: [
                        Expanded(
                            child: countItems > 0
                                ? const OrderInformationContent()
                                : const Center(
                                    child: CircularProgressIndicator(),
                                  )),
                        Expanded(child: SizedBox()),
                      ],
                    ))
                  : const Expanded(child: OrderInformationContent()),
              // const Expanded(
              //     child: Column(
              //     children: [
              //       Flexible(child: OrderInformationContent()),
              //       Expanded(
              //         child: Padding(
              //            padding: EdgeInsets.only(left: Sizes.p16 , right: Sizes.p16, bottom: Sizes.p16),
              //            child: PaymentInformationContent()),
              //       ),
              //     ],
              //   )),
              screenWidth >= Breakpoint.tablet
                  ? const SizedBox()
                  : const Padding(
                      padding: EdgeInsets.all(Sizes.p16),
                      child: PaymentInformationContent(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
