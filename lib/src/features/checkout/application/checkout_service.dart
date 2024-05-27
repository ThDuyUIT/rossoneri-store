import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rossoneri_store/main.dart';
import 'package:rossoneri_store/src/constants/date_format.dart';
import 'package:rossoneri_store/src/features/authentication/data/auth_repository.dart';
import 'package:rossoneri_store/src/features/cart/application/cart_service.dart';
import 'package:rossoneri_store/src/features/cart/data/cart_repository.dart';
import 'package:rossoneri_store/src/features/orders/data/order_repository.dart';
import 'package:rossoneri_store/src/features/orders/domain/order_model.dart';

class CheckoutService {
  final Ref ref;
  CheckoutService(this.ref);

  Future<void> checkOut(Order order) async {
    final uid = MyApp.sharePre.getString('UID');
    await ref.read(orderRepositoryProvider).addOrder(order, uid!);
    await ref.read(cartRepositoryProvider).deleteCart(uid);
  }

  Future<Order> placeOrder() async {
    final uid = MyApp.sharePre.getString('UID');
    final cart = await ref.read(cartRepositoryProvider).fetchCart(uid!);
    final total = ref.read(cartTotalProvider);

    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: uid,
      orderDate: dateCustomFormat(),
      total: total,
      orderStatus: OrderStatus.shipping,
      items: cart.items,
    );

    return order;
  }
}

final checkoutServiceProvider = Provider<CheckoutService>((ref) {
  return CheckoutService(ref);
});
