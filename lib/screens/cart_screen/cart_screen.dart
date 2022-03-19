import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:union/data/model/cart.dart';
import 'package:union/screens/cart_screen/cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
        init: CartController(),
        builder: (controller) {
          return controller.isLoading
              ? const Align(
                  alignment: Alignment.topRight,
                  child: SafeArea(
                      child: LinearProgressIndicator(
                    color: Colors.blueGrey,
                  )))
              : Scaffold(
                  appBar: AppBar(
                    title: const Text("Cart"),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListView.separated(
                      itemCount: controller.cart.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildCart(context, controller.cart[index], () {
                          controller.removeFromCart(Cart(
                              chosen: "0",
                              productId: controller.cart[index].productId));
                          controller.removeAt(index);
                        });
                      },
                      separatorBuilder: (context, index) => const Divider(
                        color: Colors.white70,
                      ),
                    ),
                  ),
                );
        });
  }

  Widget _buildCart(BuildContext context, Cart cart, void Function()? onTap) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: CachedNetworkImage(
                    imageUrl: cart.imageUrl.toString(),
                    progressIndicatorBuilder: (context, widget, _) => Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        LinearProgressIndicator(
                          color: Colors.blueGrey,
                          semanticsLabel: 'Linear progress indicator',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: Text(
                  cart.size!.isNotEmpty ? "Size: ${cart.size.toString()}" : "",
                  style: Theme.of(context).textTheme.bodyText1,
                ))
              ],
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Flexible(
                    child: Text(
                  cart.name.toString(),
                  style: Theme.of(context).textTheme.headline3,
                )),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "\$\t${cart.price.toString()}",
                      style: Theme.of(context).textTheme.bodyText1,
                    )),
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: onTap,
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 8),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white)),
                        child: Text(
                          "Remove",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.red),
                        )),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
