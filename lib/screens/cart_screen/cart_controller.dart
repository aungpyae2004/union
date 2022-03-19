import 'package:get/get.dart';
import 'package:union/data/db_helper/db_helper.dart';
import 'package:union/data/model/cart.dart';

class CartController extends GetxController {
  List<Cart> cart = [];
  bool isLoading = false;

  @override
  void onInit() {
    getCart();
    super.onInit();
  }

  void getCart() async {
    _updateIsLoading(true);
    cart = await DbHelper().getCart();
    _updateIsLoading(false);
  }

  void addToCart(Cart cart) async {
    await DbHelper().addToCart(cart);
  }

  void removeFromCart(Cart cart) async {
    await DbHelper().removeFromCart(cart);
  }

  void _updateIsLoading(bool currentStatus) {
    isLoading = currentStatus;
    update();
  }

  void removeAt(int index) {
    cart.removeAt(index);
    update();
  }
}
