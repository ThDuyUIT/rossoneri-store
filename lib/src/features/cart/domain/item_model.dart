class Item{
  final String productId;
  final int quantity;

  Item({
    required this.productId,
    required this.quantity,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Item &&
        other.productId == productId &&
        other.quantity == quantity;
  }
  
  @override
  int get hashCode => productId.hashCode ^ quantity.hashCode;

  @override
  String toString() => 'Item(productId: $productId, quantity: $quantity)';
}