import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rossoneri_store/src/features/cart/application/cart_service.dart';
import 'package:rossoneri_store/src/features/cart/domain/item_model.dart';

class ShoppingCartScreenController extends StateNotifier<AsyncValue<void>> {
  final CartService cartService;

  ShoppingCartScreenController({required this.cartService})
      : super(const AsyncData(null));

  Future<void> updateItemQuantity(String productId, int quantity) async {
    state = const AsyncLoading();
    final updatedItem = Item(productId: productId, quantity: quantity);
    state = await AsyncValue.guard(() => cartService.setItem(updatedItem));
  }

  Future<void> removeItem(String productId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => cartService.removeItem(productId));
  }
}

final shoppingCartScreenControllerProvider = StateNotifierProvider.autoDispose<
        ShoppingCartScreenController, AsyncValue<void>>(
    (ref) => ShoppingCartScreenController(
        cartService: ref.read(cartServiceProvider)));
