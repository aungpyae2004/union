import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:union/data/model/cart.dart';
import 'package:union/data/model/product.dart';
import 'package:union/screens/cart_screen/cart_controller.dart';
import 'package:union/screens/detail_screen/detail_controller.dart';

class DetailScreen extends StatefulWidget {
  final int index;
  final Product products;

  const DetailScreen({Key? key, required this.index, required this.products})
      : super(key: key);

  @override
  _DetailScreenState createState() {
    return _DetailScreenState();
  }
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.products.data![widget.index].name.toString()),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              pinned: true,
              toolbarHeight: MediaQuery.of(context).size.height * 0.25,
              automaticallyImplyLeading: false,
              flexibleSpace: CachedNetworkImage(
                imageUrl:
                    widget.products.data![widget.index].imageUrl![0].toString(),
                fit: BoxFit.fitWidth,
              )),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return _DetailBody(
                  products: widget.products,
                  index: widget.index,
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailBody extends StatefulWidget {
  const _DetailBody({required this.products, required this.index});
  final int index;
  final Product products;

  @override
  State<_DetailBody> createState() => _DetailBodyState();
}

class _DetailBodyState extends State<_DetailBody> {
  int _selectedColorIndex = 0;
  int _selectedSizeIndex = 0;

  final cartController = Get.put(CartController());
  final detailController = Get.put(DetailController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.products.data![widget.index].name.toString(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "\$\t${widget.products.data![widget.index].price.toString()}",
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              InkWell(
                onTap: () {
                  final cart = Cart(
                      price: detailController.count.value *
                          widget.products.data![widget.index].price!,
                      imageUrl: widget.products.data![widget.index]
                          .imageUrl![_selectedColorIndex],
                      size: widget.products.data![widget.index].size!.isNotEmpty
                          ? widget.products.data![widget.index]
                              .size![_selectedSizeIndex]
                          : "",
                      chosen: "1",
                      productId: widget.products.data![widget.index].id);

                  _showMaterialDialog(cart);
                },
                child: Chip(
                  backgroundColor: Colors.green,
                  label: Text(
                    'Add to cart',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text("Color", style: Theme.of(context).textTheme.headline3),
          const SizedBox(height: 8),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                widget.products.data![widget.index].imageUrl!.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedColorIndex = index;
                    });
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      border: Border.all(
                          width: 3,
                          color: _selectedColorIndex == index
                              ? Colors.amber
                              : Colors.transparent),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: widget
                          .products.data![widget.index].imageUrl![index]
                          .toString(),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          widget.products.data![widget.index].size!.isNotEmpty
              ? Column(
                  children: [
                    Text("Size", style: Theme.of(context).textTheme.headline3),
                    const SizedBox(height: 8),
                  ],
                )
              : const SizedBox(),
          SizedBox(
            width: 150,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                    widget.products.data![widget.index].size!.length,
                    (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedSizeIndex = index;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                                color: _selectedSizeIndex == index
                                    ? Colors.amber
                                    : Colors.transparent,
                                border: Border.all(
                                    color: Colors.white, width: 0.8)),
                            child: Center(
                              child: Text(
                                widget
                                    .products.data![widget.index].size![index],
                                style: TextStyle(
                                    color: _selectedSizeIndex == index
                                        ? Colors.black
                                        : Colors.white),
                              ),
                            ),
                          ),
                        ))),
          ),
          const SizedBox(height: 8),
          Text(
            "Quantity",
            style: Theme.of(context).textTheme.headline3,
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1)),
            width: 150,
            height: 25,
            child: Row(
              children: [
                Expanded(
                  child: MaterialButton(
                      onPressed: () {
                        if (detailController.count.value != 1) {
                          detailController.count.value--;
                        }
                      },
                      child: const Icon(Icons.remove)),
                ),
                Container(
                  color: Colors.white,
                  height: 25,
                  width: 0.8,
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      detailController.count.value.toString(),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  height: 25,
                  width: 0.8,
                ),
                Expanded(
                  child: MaterialButton(
                      onPressed: () {
                        detailController.count.value++;
                      },
                      child: const Icon(Icons.add)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.products.data![widget.index].explanation.toString(),
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Copyright: ${widget.products.data![widget.index].copyRight.toString()}',
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  void _showMaterialDialog(Cart cart) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Note"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'If you add an item which is already in the cart , it will be replaced with a new one.',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    cartController.addToCart(cart);
                    Get.back();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Added"),
                    ));
                  },
                  child: const Text("Add")),
            ],
          );
        });
  }
}
