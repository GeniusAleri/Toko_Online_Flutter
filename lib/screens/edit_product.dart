// ignore_for_file: must_be_immutable, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:toko_online/screens/homepage.dart';
import 'package:http/http.dart' as http;

class EditProduct extends StatelessWidget {
  final Map product;

  EditProduct({super.key, required this.product});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageurlController = TextEditingController();

  Future updateProduct() async {
    final response = await http.put(
        // untuk lokal
        Uri.parse("http://127.0.0.1:8000/api/products/${product['id']}"),

        // untuk emulator
        // Uri.parse("http://10.0.2.2:8000/api/products/${product['id']}"),

        body: {
          "name": _nameController.text,
          "description": _descriptionController.text,
          "price": _priceController.text,
          "image_url": _imageurlController.text
        });
    print(response.body);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Product"),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController..text = product['name'],
                  decoration: const InputDecoration(labelText: "Name"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Masukan Nama Produk";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController
                    ..text = product['description'],
                  decoration: const InputDecoration(labelText: "Description"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Masukan Deskripsi Produk";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _priceController..text = product['price'],
                  decoration: const InputDecoration(labelText: "Price"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Masukan Harga Produk";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _imageurlController..text = product['image_url'],
                  decoration: const InputDecoration(labelText: "Image_URL"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Masukan Image_Url Produk";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        updateProduct().then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Produk Berhasil di Edit")));
                        });
                      } else {}
                    },
                    child: const Text("Update"))
              ],
            )),
      ),
    );
  }
}
