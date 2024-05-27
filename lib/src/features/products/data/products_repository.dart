import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rossoneri_store/src/constants/test_products.dart';
import 'package:rossoneri_store/src/features/products/domain/kind_of_products_model.dart';
import 'package:rossoneri_store/src/features/products/domain/product_model.dart';
import 'package:rossoneri_store/src/features/products/presentation/controllers/product_filter_state_provider.dart';
import 'package:rossoneri_store/src/untils/in_memory_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire;

abstract class IproductsRepository {
  Future<List<Product>> getProductsList();
  Stream<List<Product>> watchProductsList();
  Future<Product> getProduct(String productId);
  Future<List<Product>> searchProducts(String search, String kindId);
  Future<List<KindOfProducts>> getKindsOfProducts();
  Future<List<Product>> filterProductsByKind(String kindId);
}

// class FakeProductsRepository implements IproductsRepository {
//   final _products = InMemoryStore<List<Product>>(List.from(kTestProducts));
//   final _kinds =
//       InMemoryStore<List<KindOfProducts>>(List.from(kTestKindOfProducts));

//   @override
//   Future<List<Product>> getProductsList() async {
//     return _products.value;
//   }

//   @override
//   Future<List<KindOfProducts>> getKindsOfProducts() async {
//     return _kinds.value;
//   }

//   @override
//   Future<List<Product>> filterProductsByKind(String kindId) async {
//     final productsList = await getProductsList();
//     return productsList.where((product) => product.kind == kindId).toList();
//   }

//   @override
//   Future<Product> getProduct(String productId) async {
//     final productsList = await getProductsList();
//     return productsList.firstWhere((product) => product.productId == productId);
//   }

//   @override
//   Future<List<Product>> searchProducts(String key, String kindId) async {
//     late List<Product> productsList;
//     if (kindId.isEmpty) {
//       productsList = await getProductsList();
//     } else {
//       productsList = await filterProductsByKind(kindId);
//     }
//     return productsList
//         .where((element) =>
//             element.title.toLowerCase().contains(key.toLowerCase()))
//         .toList();
//   }
// }

// final fakeProductsRepository = Provider<IproductsRepository>(
//   (ref) => FakeProductsRepository(),
// );

// user fakeProductsRepository

// final productsListProvider = FutureProvider<List<Product>>(
//   (ref) => ref.watch(fakeProductsRepository).getProductsList(),
// );

// final kindsOfProductsProvider = FutureProvider<List<KindOfProducts>>(
//   (ref) => ref.watch(fakeProductsRepository).getKindsOfProducts(),
// );

// final productProvider = FutureProvider.family<Product, String>(
//   (ref, productId) => ref.watch(fakeProductsRepository).getProduct(productId),
// );

// final filterProductByKind = FutureProvider<List<Product>>(
//   (ref) {
//     final kindId = ref.watch(productFilterStateProvider);
//     return ref.read(fakeProductsRepository).filterProductsByKind(kindId);
//   }
// );

class ProductsRepository implements IproductsRepository {
  const ProductsRepository(this._firestore);
  final FirebaseFirestore _firestore;

  DocumentReference<Product> _productRef(String? id) =>
      _firestore.collection('products').doc(id).withConverter(
            fromFirestore: (doc, _) => Product.fromMap(doc.data()!),
            toFirestore: (Product product, options) => product.toMap(),
          );

  Query<Product> _productsRef() =>
      _firestore.collection('products').withConverter(
            fromFirestore: (doc, _) {
              final product = Product.fromMap(doc.data()!);

              product.productId = doc.id.toString();
              return product;
            },
            toFirestore: (Product product, options) => product.toMap(),
          );
  //.orderBy('id');

  Query<KindOfProducts> _kindsRef() =>
      _firestore.collection('kinds').withConverter(
            fromFirestore: (doc, _) {
              final kind = KindOfProducts.fromMap(doc.data()!);
              kind.id = doc.id.toString();
              return kind;
            },
            toFirestore: (KindOfProducts kind, options) => kind.toMap(),
          );
  //.orderBy('id');
  @override
  Future<Product> getProduct(String productId) async {
    final ref = _productRef(productId);
    final snapshot = await ref.get();
    final product = snapshot.data();
    product!.productId = snapshot.id;
    return product;
  }

  @override
  Future<List<Product>> getProductsList() async {
    final ref = _productsRef();
    final snapshot = await ref.get();
    return snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  @override
  Stream<List<Product>> watchProductsList() {
    final ref = _productsRef();
    return ref.snapshots().map((snapshot) =>
        snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList());
  }

  @override
  Future<List<KindOfProducts>> getKindsOfProducts() async {
    final ref = _kindsRef();
    final snapshot = await ref.get();
    return snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  @override
  Future<List<Product>> filterProductsByKind(String kindId) async {
    final productsList = await getProductsList();
    return productsList.where((product) => product.kind == kindId).toList();
  }

  @override
  Future<List<Product>> searchProducts(String key, String kindId) async {
    late List<Product> productsList;
    if (kindId.isEmpty) {
      productsList = await getProductsList();
    } else {
      productsList = await filterProductsByKind(kindId);
    }
    return productsList
        .where((element) =>
            element.title.toLowerCase().contains(key.toLowerCase()))
        .toList();
  }
}

final productsRepositoryProvider = Provider<ProductsRepository>(
  (ref) {
    final firestore = FirebaseFirestore.instance;
    return ProductsRepository(firestore);
  },
);

final productsListProvider = FutureProvider<List<Product>>(
  (ref) => ref.watch(productsRepositoryProvider).getProductsList(),
);

final productsListStreamProvider = StreamProvider<List<Product>>(
  (ref) => ref.watch(productsRepositoryProvider).watchProductsList(),
);

final productProvider = FutureProvider.family<Product, String>(
  (ref, productId) =>
      ref.watch(productsRepositoryProvider).getProduct(productId),
);

final kindsOfProductsProvider = FutureProvider<List<KindOfProducts>>(
  (ref) => ref.watch(productsRepositoryProvider).getKindsOfProducts(),
);

final filterProductByKind = FutureProvider<List<Product>>((ref) {
  final kindId = ref.watch(productFilterStateProvider);
  return ref.read(productsRepositoryProvider).filterProductsByKind(kindId);
});

final productsListSearchProvider = FutureProvider.autoDispose
    .family<List<Product>, String>((ref, search) async {
  final link = ref.keepAlive();
  // * keep previous search results in memory for 60 seconds
  final timer = Timer(const Duration(seconds: 60), () {
    link.close();
  });
  final kindId = ref.watch(productFilterStateProvider);
  return ref.watch(productsRepositoryProvider).searchProducts(search, kindId);
});
