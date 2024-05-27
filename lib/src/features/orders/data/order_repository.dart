import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rossoneri_store/main.dart';
import 'package:rossoneri_store/src/features/orders/domain/order_model.dart'
    as OrderModel;

class OrderRepository {
  OrderRepository(this._firestore);
  final FirebaseFirestore _firestore;

  DocumentReference<OrderModel.Order> _orderUserRef(String userId) {
    return _firestore.collection('users/$userId/orders').doc().withConverter(
        fromFirestore: (doc, _) => OrderModel.Order.fromMap(doc.data()!),
        toFirestore: (order, _) => order.toMap());
  }

  Future<void> addOrder(OrderModel.Order order, String userId) async {
    final ref = _orderUserRef(userId);
    await ref.set(order);
  }

  Query<OrderModel.Order> _ordersQuery(String userId) {
    var query = _firestore.collectionGroup('orders').where('userId', isEqualTo: userId);
    return query.orderBy(FieldPath.documentId, descending: true).withConverter(
        fromFirestore: (doc, _) => OrderModel.Order.fromMap(doc.data()!),
        toFirestore: (order, _) => order.toMap());
  }

  // Stream<List<OrderModel.Order>> watchOrders(String userId) {
  //   final ref = _ordersQuery(userId);
  //   return ref.snapshots().map((snapshot) =>
  //       snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList());
  // }

  Future<List<OrderModel.Order>> getOrders(String userId) async {
    final ref = _ordersQuery(userId);
    final snapshot = await ref.get();
    return snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

}

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  return OrderRepository(FirebaseFirestore.instance);
});

final ordersListProvider =
    FutureProvider.autoDispose<List<OrderModel.Order>>((ref) async {
  final repository = ref.read(orderRepositoryProvider);
  return repository.getOrders(MyApp.sharePre.getString('UID')!);
});
