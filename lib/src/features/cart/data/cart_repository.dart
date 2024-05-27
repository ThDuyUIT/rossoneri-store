import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rossoneri_store/src/features/cart/domain/cart_model.dart';
import 'package:rossoneri_store/src/untils/delay.dart';
import 'package:rossoneri_store/src/untils/in_memory_store.dart';

abstract class ICartRepository {
  Future<Cart> fetchCart(String uid);
  Stream<Cart> watchCart(String uid);
  Future<void> setCart(Cart cart, String uid);
  Future<void> deleteCart(String uid);
}

class FakeCartRepository implements ICartRepository {
  final _cart = InMemoryStore<Cart>(const Cart());

  @override
  Stream<Cart> watchCart(String uid) {
    return _cart.stream;
  }

  @override
  Future<Cart> fetchCart(String uid) {
    return Future.value(_cart.value);
  }

  @override
  Future<void> setCart(Cart cart, String uid) async {
    await delay(true);
    _cart.value = cart;
  }

  @override
  Future<void> deleteCart(String uid) {
    // TODO: implement deleteCart
    throw UnimplementedError();
  }
}

final fakeCartRepositoryProvider = Provider<FakeCartRepository>((ref) {
  return FakeCartRepository();
});

class CartRepository implements ICartRepository {
  final FirebaseFirestore _firestore;

  CartRepository(this._firestore);

  @override
  Stream<Cart> watchCart(String uid) {
    final ref = _cartRef(uid);
    return ref.snapshots().map((doc) => doc.data() ?? const Cart());
  }

  @override
  Future<Cart> fetchCart(String uid) {
    final ref = _cartRef(uid);
    return ref.get().then((doc) => doc.data() ?? const Cart());
  }

  @override
  Future<void> setCart(Cart cart, String uid) async {
    final ref = _cartRef(uid);
    await ref.set(cart);
  }

  DocumentReference<Cart> _cartRef(String uid) =>
      _firestore.collection('carts').doc(uid).withConverter(
            fromFirestore: (doc, _) => Cart.fromMap(doc.data()!),
            toFirestore: (cart, _) => cart.toMap(),
          );

  @override
  Future<void> deleteCart(String uid) {
    final ref = _cartRef(uid);
    return ref.delete();
  }
}

final cartRepositoryProvider = Provider<CartRepository>((ref) {
  return CartRepository(FirebaseFirestore.instance);
});
