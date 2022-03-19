class Cart {
  int? id;
  String? name;
  int? price;
  String? imageUrl;
  int? productId;
  String? size;
  String? chosen;

  Cart({
    this.id,
    this.name,
    this.price,
    this.imageUrl,
    this.productId,
    this.size,
    this.chosen,
  });
  Map<String, Object?> toMap() {
    var map = <String, dynamic>{
      "id": id,
      "name": name,
      "price": price,
      "image_url": imageUrl,
      "product_id": productId,
      "size": size,
      "chosen": chosen
    };
    return map;
  }

  Cart.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    name = map["name"];
    price = map["price"];
    imageUrl = map["image_url"];
    productId = map["product_id"];
    size = map["size"];
    chosen = map["chosen"];
  }
}
