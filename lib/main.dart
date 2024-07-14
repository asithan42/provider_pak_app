import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_pak_app/pages/product_page.dart';
import 'package:provider_pak_app/providers/cart_provider.dart';
import 'package:provider_pak_app/providers/favourite_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => FavouriteProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductPage(),
    );
  }
}
