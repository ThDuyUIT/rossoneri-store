import 'package:rossoneri_store/src/features/cart/domain/item_model.dart';

class Cart {
  final Map<String, int> items;

  const Cart([
    this.items = const {},
  ]);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Cart && other.items == items;
  }

  @override
  int get hashCode => items.hashCode;

  Cart copyWith({
    Map<String, int>? items,
  }) {
    return Cart(
      items ?? this.items,
    );
  }

  List<Item> toItemsList() {
    return items.entries
        .map((e) => Item(productId: e.key, quantity: e.value))
        .toList();
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(Map<String, int>.from(map['items']));
  }

  Map<String, dynamic> toMap() => {
    'items': items,
  };

  Cart addItem(Item item) {
    final copy = Map<String, int>.from(items);
    copy.update(item.productId, 
        // update quantity of already item in cart
        (value) => value + item.quantity,
        // add new item to cart
        ifAbsent: () => item.quantity);
    return copyWith(items: copy);
  }

  Cart setItem(Item item) {
    final copy = Map<String, int>.from(items);
    copy[item.productId] = item.quantity;
    return Cart(copy);
  }

  Cart removeItemById(String productId) {
    final copy = Map<String, int>.from(items);
    copy.remove(productId);
    return Cart(copy);
  }

  @override
  String toString() {
    return 'Cart(items: $items)';
  }
}
