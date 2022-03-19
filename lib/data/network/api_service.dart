import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:union/data/model/product.dart';

class ApiService {
  Future<Product> fetchProducts() async {
    var product = Product();
    try {
      final response = await http.get(Uri.parse(
          'https://62342b056d5465eaa515355e.mockapi.io/api/products'));
      if (response.statusCode == 200) {
        return product = Product.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print("Error occurred");
    }
    return product;
  }
}
