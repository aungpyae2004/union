class Product {
  Product({
      this.data,});

  Product.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Data {
  Data({
      this.name, 
      this.price, 
      this.imageUrl, 
      this.copyRight, 
      this.explanation, 
      this.size, 
      this.id,});

  Data.fromJson(dynamic json) {
    name = json['name'];
    price = json['price'];
    imageUrl = json['image_url'] != null ? json['image_url'].cast<String>() : [];
    copyRight = json['copy_right'];
    explanation = json['explanation'];
    size = json['size'] != null ? json['size'].cast<String>() : [];
    id = json['id'];
  }
  String? name;
  int? price;
  List<String>? imageUrl;
  String? copyRight;
  String? explanation;
  List<String>? size;
  int? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['price'] = price;
    map['image_url'] = imageUrl;
    map['copy_right'] = copyRight;
    map['explanation'] = explanation;
    map['size'] = size;
    map['id'] = id;
    return map;
  }

}