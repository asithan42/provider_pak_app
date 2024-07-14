import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_pak_app/models/cart_model.dart';
import 'package:provider_pak_app/providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Cart Page",
          style: TextStyle(
              fontSize: 25,
              color: Color(0xFF069A0B),
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<CartProvider>(
        builder:
            // ignore: non_constant_identifier_names
            (BuildContext context, CartProvider CartProvider, Widget? child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: CartProvider.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    final CartItem cartItem =
                        CartProvider.items.values.toList()[index];
                    return Card(
                      color: const Color(0xFF85E5EB).withOpacity(0.8),
                      child: ListTile(
                        title: Text(cartItem.title),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(cartItem.id),
                            Text("\$${cartItem.price} x ${cartItem.quantity}")
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                CartProvider.removeSingleItem(cartItem.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Remove single item!"),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.remove),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            IconButton(
                              onPressed: () {
                                CartProvider.removeItem(cartItem.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Remove items!"),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.remove_shopping_cart),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Total: \$${CartProvider.totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    // clear cart
                    CartProvider.clearAll();

                    // show snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Cart cleared!'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  child: const Text("Clear Cart"),
                ),),
            ],
          );
        },
      ),
    );
  }
}
