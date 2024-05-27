import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rossoneri_store/src/features/authentication/data/auth_repository.dart';
import 'package:rossoneri_store/src/features/cart/data/cart_repository.dart';
import 'package:rossoneri_store/src/features/cart/domain/cart_model.dart';
import 'package:rossoneri_store/src/features/cart/domain/item_model.dart';
import 'package:rossoneri_store/src/features/products/data/products_repository.dart';
import 'package:rossoneri_store/src/features/products/domain/product_model.dart';

class CartService {
  final Ref ref;

  CartService(this.ref);

  //fetch cart data
  Future<Cart> _fetchCart() async {
    final uidAuth = ref.read(authStateChangesProvider).value;
    if (uidAuth != null) {
      return await ref.watch(cartRepositoryProvider).fetchCart(uidAuth);
    } else
      return await ref.watch(fakeCartRepositoryProvider).fetchCart('');
  }

  //set cart data
  Future<void> _setCart(Cart cart) async {
    final uidAuth = ref.read(authStateChangesProvider).value;
    if (uidAuth != null) {
      await ref.watch(cartRepositoryProvider).setCart(cart, uidAuth);
    } else
      await ref.watch(fakeCartRepositoryProvider).setCart(cart, '');
  }

  //add item to cart (from add_to_cart_button)
  Future<void> addItem(Item item) async {
    final cart = await _fetchCart();

    final updatedCart = cart.addItem(item);
    await _setCart(updatedCart);
  }

  //update already item quantity in cart (from cart_item)
  Future<void> setItem(Item item) async {
    final cart = await _fetchCart();
    final updatedCart = cart.setItem(item);
    await _setCart(updatedCart);
  }

  //remove item from cart (from cart_item)
  Future<void> removeItem(String productID) async {
    final cart = await _fetchCart();
    final updated = cart.removeItemById(productID);
    await _setCart(updated);
  }
}

final cartServiceProvider = Provider<CartService>((ref) {
  return CartService(ref);
});

final cartProvider = StreamProvider<Cart>((ref) {
  final uid = ref.watch(authStateChangesProvider).value;
  if (uid != null) {
    return ref.watch(cartRepositoryProvider).watchCart(uid);
  } else {
    return ref.watch(fakeCartRepositoryProvider).watchCart('');
  }
});

final itemAvailableQuantityProvider =
    Provider.autoDispose.family<int, Product>((ref, product) {
  final cart = ref.watch(cartProvider).value;
  if (cart != null) {
    final quantity = cart.items[product.productId] ?? 0;
    return max(0, product.availableQuantity - quantity);
  } else {
    return product.availableQuantity;
  }
});

final cartItemsCountProvider = Provider.autoDispose<int>((ref) {
  return ref
      .watch(cartProvider)
      .maybeMap(orElse: () => 0, data: (cart) => cart.value.items.length);
});

final cartTotalProvider = Provider.autoDispose<double>((ref) {
  final cart = ref.watch(cartProvider).value;
  final products = ref.watch(productsListStreamProvider).value ?? [];
  if (cart!.items.isNotEmpty && products.isNotEmpty) {
    var total = 0.0;
    cart.toItemsList().forEach((element) {
      //print('element ' + element.toString());
      final product =
          products.firstWhere((p) => p.productId == element.productId);
      total += product.price * element.quantity;
    });
    return total;
  }
  return 0.0;
});
