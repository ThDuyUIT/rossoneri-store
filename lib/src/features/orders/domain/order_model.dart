enum OrderStatus { confirmed, shipping, delivered }

extension OrderStatusString on OrderStatus {
  static OrderStatus fromString(String string) {
    if (string == 'confirmed') return OrderStatus.confirmed;
    if (string == 'shipping') return OrderStatus.shipping;
    if (string == 'delivered') return OrderStatus.delivered;
    throw ArgumentError('Invalid order status string: $string');
  }
}

class Order {
  final String id;
  final String userId;
  final String orderDate;
  final double total;
  final OrderStatus orderStatus;
  final Map<String, int> items;

  Order({
    required this.id,
    required this.userId,
    required this.orderDate,
    required this.total,
    required this.orderStatus,
    required this.items,
  });

  Order copyWith({
    String? id,
    String? userId,
    String? orderDate,
    double? total,
    OrderStatus? orderStatus,
  }) {
    return Order(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      orderDate: orderDate ?? this.orderDate,
      total: total ?? this.total,
      orderStatus: orderStatus ?? this.orderStatus,
      items: items ?? this.items,
    );
  }

  @override
  String toString() {
    return 'Order(id: $id, userId: $userId, orderDate: $orderDate, total: $total, orderStatus: $orderStatus)';
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      userId: map['userId'],
      orderDate: map['orderDate'],
      total: map['total'],
      orderStatus:
          OrderStatusString.fromString(map['orderStatus']),
      items: Map<String, int>.from(map['items']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'orderDate': orderDate,
      'total': total,
      'orderStatus': orderStatus.name,
      'items': items,
    };
  }
}
