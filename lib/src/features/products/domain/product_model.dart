
class Product {
   String productId;
   String imageUrl;
   String title;
   String description;
   String kind;
   double price;
   int availableQuantity;
   double avgRating;
   double numRatings;

  Product({
     this.productId = '',
     this.imageUrl = '',
     this.title = '',
     this.description = '',
     this.kind = '',
     this.price = 0.0,
     this.availableQuantity = 0,
    this.avgRating = 0.0,
    this.numRatings = 0.0,
  });

  @override
  String toString() {
    // TODO: implement toString
    return 'Product{productId: $productId, imageUrl: $imageUrl, title: $title, description: $description, price: $price, availableQuantity: $availableQuantity, avgRating: $avgRating, numRatings: $numRatings}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.productId == productId &&
        other.imageUrl == imageUrl &&
        other.title == title &&
        other.description == description &&
        other.price == price &&
        other.availableQuantity == availableQuantity &&
        other.avgRating == avgRating &&
        other.numRatings == numRatings &&
        other.kind == kind;
  }

  // @override
  // int get hashCode {
  //   return productId.hashCode ^
  //       imageUrl.hashCode ^
  //       title.hashCode ^
  //       description.hashCode ^
  //       price.hashCode ^
  //       availableQuantity.hashCode ^
  //       avgRating.hashCode ^
  //       numRatings.hashCode;
  // }

  Product copyWith({
    String? productId,
    String? imageUrl,
    String? title,
    String? description,
    double? price,
    int? availableQuantity,
    double? avgRating,
    double? numRatings,
    String? kind,
  }) {
    return Product(
      productId: productId ?? this.productId,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      availableQuantity: availableQuantity ?? this.availableQuantity,
      avgRating: avgRating ?? this.avgRating,
      numRatings: numRatings ?? this.numRatings,
      kind: kind ?? this.kind,
    );
  }

  factory Product.fromMap(Map<String, dynamic> map) {
  return Product(
    imageUrl: map['imageUrl'],
    title: map['title'],
    description: map['description'],
    kind: map['kind'],
    price: map['price'] is int ? (map['price'] as int).toDouble() : map['price'],
    availableQuantity: map['availableQuantity'],
    avgRating: map['avgRating'] is int ? (map['avgRating'] as int).toDouble() : map['avgRating'],
    numRatings: map['numRatings'] is int ? (map['numRatings'] as int).toDouble() : map['numRatings'],
  );
}

  Map<String, dynamic> toMap() {
    return {
      //'productId': productId,
      'imageUrl': imageUrl,
      'title': title,
      'description': description,
      'kind': kind,
      'price': price,
      'availableQuantity': availableQuantity,
      'avgRating': avgRating,
      'numRatings': numRatings,
    };
  }
}
