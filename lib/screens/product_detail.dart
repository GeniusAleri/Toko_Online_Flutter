// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  final Map product;

  const ProductDetail({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail'),
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            width: 300,
            child: Image.network(
              product['image_url'],
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product['price'],
                  style: TextStyle(fontSize: 22),
                ),
                Row(
                  children: [
                    Icon(Icons.edit),
                    Icon(Icons.delete),
                  ],
                )
              ],
            ),
          ),
          Text(product['description']),
        ],
      ),
    );
  }
}
