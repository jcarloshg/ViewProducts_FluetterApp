import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forms_validators/models/models.index.dart';
import 'package:http/http.dart' as http;

class ProductstServices extends ChangeNotifier {
  final String _baseUrl =
      'flutterappproducts-c312d-default-rtdb.firebaseio.com';

  final List<Product> productos = [];
  bool isLoading = false;

  ProductstServices() {
    loadProducts();
  }

  Future<List<Product>> loadProducts() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'products.json');
    final res = await http.get(url);
    final Map<String, dynamic> productsMaps = json.decode(res.body);

    List<Product> productos = [];

    productsMaps.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      productos.add(tempProduct);
    });

    isLoading = false;
    notifyListeners();

    return productos;
  }

  // todo fetch productos
}
