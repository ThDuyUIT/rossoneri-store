import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rossoneri_store/main.dart';
import 'package:rossoneri_store/src/common_widgets.dart/async_value_widget.dart';
import 'package:rossoneri_store/src/features/orders/data/order_repository.dart';
import 'package:rossoneri_store/src/features/orders/presentation/order_item_widget.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersValue = ref.watch(ordersListProvider);
    return Scaffold(
        body: AsyncValueWidget(
            value: ordersValue,
            data: (orders) {
              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return OrderItemWidget(order: order);
                },
              );
            }));
  }
}
