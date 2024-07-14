import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_pak_app/data/product_data.dart';
import 'package:provider_pak_app/models/product_model.dart';
import 'package:provider_pak_app/pages/cart_page.dart';
import 'package:provider_pak_app/pages/favorite_page.dart';
import 'package:provider_pak_app/providers/cart_provider.dart';
import 'package:provider_pak_app/providers/favourite_provider.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> products = ProductData().products;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Flutter Shop",
          style: TextStyle(
              fontSize: 25,
              color: Color(0xFF069A0B),
              fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FavoritePage(),
                  ));
            },
            heroTag: "favorite_button",
            backgroundColor: Colors.red,
            child: const Icon(
              Icons.favorite,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartPage(),
                  ));
            },
            heroTag: "cart_button",
            backgroundColor: Colors.red,
            child: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final Product product = products[index];
          return Card(
            child: Consumer2<CartProvider, FavouriteProvider>(
              // ignore: non_constant_identifier_names
              builder: (BuildContext context, CartProvider CartProvider,
                  // ignore: non_constant_identifier_names
                  FavouriteProvider FavouriteProvider, Widget? child) {
                return ListTile(
                  title: Row(
                    children: [
                      Text(
                        product.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        CartProvider.items.containsKey(product.id)
                            ? CartProvider.items[product.id]!.quantity
                                .toString()
                            : "0",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  subtitle: Text("\$${product.price.toString()}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          FavouriteProvider.toggleFavourites(product.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                FavouriteProvider.isFavourite(product.id)
                                    ? "Added to favorite!"
                                    : "Remove from favourite!",
                              ),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        icon: Icon(
                          FavouriteProvider.isFavourite(product.id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: FavouriteProvider.isFavourite(product.id)
                              ? Colors.pinkAccent
                              : Colors.grey,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          CartProvider.addItem(
                            product.id,
                            product.price,
                            product.title,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Added to cart!"),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.shopping_cart,
                          color: CartProvider.items.containsKey(product.id)
                              ? Colors.deepOrange
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
