import 'package:flutter/material.dart';

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
    );
  }
}