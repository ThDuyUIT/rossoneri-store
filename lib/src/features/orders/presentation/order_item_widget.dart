import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rossoneri_store/src/constants/app_colors.dart';
import 'package:rossoneri_store/src/constants/app_sizes.dart';
import 'package:rossoneri_store/src/features/cart/domain/item_model.dart';
import 'package:rossoneri_store/src/features/orders/domain/order_model.dart';
import 'package:rossoneri_store/src/features/orders/presentation/order_item_list_tile.dart';

class OrderItemWidget extends StatelessWidget {
  final Order order;

  const OrderItemWidget({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1, color: Colors.grey[400]!),
        borderRadius: const BorderRadius.all(Radius.circular(Sizes.p8)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p16),
        child: Column(
          children: [
            OrderItemHeader(order: order),
            gapH16,
            const Divider(height: 1, color: Colors.grey),
            gapH16,
            OrderItemList(order: order)
          ],
        ),
      ),
    );
  }
}

class OrderItemHeader extends StatelessWidget {
  final Order order;

  const OrderItemHeader({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(order.id, style: Theme.of(context).textTheme.titleMedium),
            Text(
              'Created at: ${order.orderDate}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text('Order Status: ${order.orderStatus.name}',
                style: Theme.of(context).textTheme.titleMedium),
          ],
        )),
        Text(
          'Total \$ ${order.total}',
          textAlign: TextAlign.right,
          style: Theme.of(context).textTheme.titleMedium,
        )
      ],
    );
  }
}

class OrderItemList extends StatelessWidget {
  final Order order;

  const OrderItemList({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var entry in order.items.entries)
          OrderItemListTile(
              item: Item(productId: entry.key, quantity: entry.value))
      ],
    );
  }
}
