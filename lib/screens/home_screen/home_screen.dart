import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:union/screens/cart_screen/cart_screen.dart';
import 'package:union/screens/detail_screen/detail_screen.dart';
import 'package:union/screens/home_screen/home_controller.dart';
import '../../data/model/product.dart';

class HomePage extends StatelessWidget {
  final String title;

  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return controller.isLoading
              ? Center(
                  child: Text(
                    "Be Patient",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                )
              : Scaffold(
                  appBar: AppBar(
                    title: Text(title),
                    actions: [
                      MaterialButton(
                          onPressed: () {
                            Get.to(const CartScreen());
                          },
                          child: const Icon(
                            Icons.shopping_cart_rounded,
                          ))
                    ],
                  ),
                  body: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: controller.product.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                Get.to(DetailScreen(
                                  index: index,
                                  products: controller.product,
                                ));
                              },
                              child: _buildProductsCard(
                                  controller.product, index));
                        },
                      ),
                    ),
                  ),
                );
        });
  }

  Widget _buildProductsCard(Product products, int index) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 250,
              child: CachedNetworkImage(
                imageUrl: products.data![index].imageUrl![0].toString(),
                progressIndicatorBuilder: (context, widget, _) => Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    LinearProgressIndicator(
                      color: Colors.blueGrey,
                      semanticsLabel: 'Linear progress indicator',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Text(
            products.data![index].name.toString(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "\$\t${products.data![index].price.toString()}",
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
