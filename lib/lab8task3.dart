import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(Aimocart());
}

class Aimocart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Girly Shopping Cart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ProductListScreen(),
    );
  }
}

class Product {
  final String name;
  final double price;

  Product({required this.name, required this.price});
}

class CartController extends GetxController {
  var cartItems = <Product>[].obs;

  void addToCart(Product product) {
    cartItems.add(product);
  }

  void removeFromCart(Product product) {
    cartItems.remove(product);
  }

  double get totalPrice => cartItems.fold(0, (sum, item) => sum + item.price);
}

class ProductListScreen extends StatelessWidget {
  final CartController cartController = Get.put(CartController());

  final List<Product> products = [
    Product(name: 'Lipstick', price: 15.0),
    Product(name: 'Perfume', price: 50.0),
    Product(name: 'Handbag', price: 120.0),
    Product(name: 'Foundation', price: 30.0),
    Product(name: 'Mascara', price: 20.0),
    Product(name: 'Blush', price: 25.0),
    Product(name: 'Eyeshadow Palette', price: 40.0),
    Product(name: 'Nail Polish', price: 10.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('My Shopping Cart')),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Get.to(() => CartScreen());
            },
          ),
        ],
      ),
      body: Container(
        color: Color.fromARGB(255, 245, 186, 179),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ListTile(
              title: Text(product.name),
              subtitle: Text('\$${product.price}'),
              trailing: IconButton(
                icon: Icon(Icons.add_shopping_cart,
                    color: const Color.fromARGB(255, 240, 126, 164)),
                onPressed: () {
                  cartController.addToCart(product);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: Container(
        color: Color.fromARGB(255, 248, 183, 176),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: cartController.cartItems.length,
                  itemBuilder: (context, index) {
                    final product = cartController.cartItems[index];
                    return ListTile(
                      title: Text(product.name),
                      subtitle: Text('\$${product.price}'),
                      trailing: IconButton(
                        icon: Icon(Icons.remove_shopping_cart,
                            color: const Color.fromARGB(255, 224, 102, 143)),
                        onPressed: () {
                          cartController.removeFromCart(product);
                        },
                      ),
                    );
                  },
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Total: \$${cartController.totalPrice}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
