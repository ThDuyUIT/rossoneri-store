import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rossoneri_store/src/features/checkout/application/checkout_service.dart';
import 'package:rossoneri_store/src/features/orders/domain/order_model.dart';

class CheckoutController extends StateNotifier<AsyncValue<void>>{
   final CheckoutService checkoutService;

  CheckoutController({required this.checkoutService}) : super(const AsyncData(null));

  Future<void> checkOut() async {
    state = const AsyncLoading();
    final order = await checkoutService.placeOrder();
    final newState = await AsyncValue.guard(() => checkoutService.checkOut(order));
    if(mounted){
      state = newState;
    }
  }
}

final checkoutControllerProvider = StateNotifierProvider.autoDispose<CheckoutController, AsyncValue<void>>(
  (ref) => CheckoutController(checkoutService: ref.read(checkoutServiceProvider))
);