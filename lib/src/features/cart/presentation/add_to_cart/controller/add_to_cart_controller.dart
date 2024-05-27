import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rossoneri_store/src/features/cart/application/cart_service.dart';
import 'package:rossoneri_store/src/features/cart/domain/cart_model.dart';
import 'package:rossoneri_store/src/features/cart/domain/item_model.dart';
import 'package:rossoneri_store/src/features/products/domain/product_model.dart';

class AddToCartController extends StateNotifier<AsyncValue<int>> {
  final CartService cartService;

  AddToCartController({required this.cartService})
      : super(const AsyncValue.data(1));

  void updateQuantity(int quantity) {
    state = AsyncValue.data(quantity);
  }

  Future<void> addItems(String productId) async {
    final item = Item(productId: productId, quantity: state.value!);
    await cartService.addItem(item);
  }
}

final addToCartControllerProvider =
    StateNotifierProvider.autoDispose<AddToCartController, AsyncValue<int>>(
        (ref) {
  final cartService = ref.watch(cartServiceProvider);
  return AddToCartController(cartService: cartService);
});

// final addToCartControllerProvider = StateNotifierProvider.autoDispose
//     .family<AddToCartController, AsyncValue<int>, CartService>(
//   (ref, cartService) => AddToCartController(cartService: cartService),
// );

