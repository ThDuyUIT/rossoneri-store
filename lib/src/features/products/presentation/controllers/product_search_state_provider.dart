import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rossoneri_store/src/features/products/data/products_repository.dart';
import 'package:rossoneri_store/src/features/products/domain/product_model.dart';

final productSearchStateProvider = StateProvider<String>((ref) => '');

final productSearchResultProvider =
    FutureProvider.autoDispose<List<Product>>((ref) async {
  final searchState = ref.watch(productSearchStateProvider);
  return ref.watch(productsListSearchProvider(searchState).future);
});
