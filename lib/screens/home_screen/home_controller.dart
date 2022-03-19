import 'package:get/get.dart';
import 'package:union/data/model/product.dart';
import 'package:union/data/network/api_service.dart';

class HomeController extends GetxController {
  var product = Product();
  final _apiService = ApiService();
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    _dataIsLoading(true);
    product = await _apiService.fetchProducts();
    _dataIsLoading(false);
  }

  void _dataIsLoading(bool currentStatus) {
    isLoading = currentStatus;
    update();
  }
}
