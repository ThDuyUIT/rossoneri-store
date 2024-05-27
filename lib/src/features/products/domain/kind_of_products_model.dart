class KindOfProducts {
   String id;
   String name;
   String idParentKind;

  KindOfProducts({
    this.id = '', 
    this.name = '',
    this.idParentKind = '',
  });

  KindOfProducts copyWith({
    String? id,
    String? name,
    String? idParentKind,
  }) {
    return KindOfProducts(
      id: id ?? this.id,
      name: name ?? this.name,
      idParentKind: idParentKind ?? this.idParentKind,
    );
  }

  factory KindOfProducts.fromMap(Map<String, dynamic> map) {
    return KindOfProducts(
      //id: map['id'],
      name: map['name'],
      //idParentKind: map['idParentKind'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      //'id': id,
      'name': name,
      //'idParentKind': idParentKind,
    };
  }
}
