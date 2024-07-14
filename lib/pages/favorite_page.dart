import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_pak_app/providers/favourite_provider.dart';

import '../data/product_data.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Favorite Page",
          style: TextStyle(
              fontSize: 25,
              color: Color(0xFF069A0B),
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<FavouriteProvider>(
        // ignore: non_constant_identifier_names
        builder: (BuildContext context, FavouriteProvider FavouriteProvider,
            Widget? child) {
          final favoriteItems = FavouriteProvider.favourites.entries
              .where((entry) => entry.value)
              .map((entry) => entry.key)
              .toList();

          if (favoriteItems.isEmpty) {
            return const Center(
              child: Text('No favorites added yet!'),
            );
          }

          return ListView.builder(
            itemCount: favoriteItems.length,
            itemBuilder: (context, index) {
              final productId = favoriteItems[index];
              final product = ProductData()
                  .products
                  .firstWhere((product) => product.id == productId);

              return Card(
                child: ListTile(
                  title: Text(product.title),
                  subtitle: Text('\$${product.price}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      FavouriteProvider.toggleFavourites(product.id);

                      // Show snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Removed from favorites!'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
