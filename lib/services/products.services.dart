import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forms_validators/models/models.index.dart';
import 'package:http/http.dart' as http;

class ProductstServices extends ChangeNotifier {
  final String _baseUrl =
      'flutterappproducts-c312d-default-rtdb.firebaseio.com';

  final List<Product> productos = [];
  bool isLoading = false;
  bool isSaving = false;

  late Product selectedProduct;

  ProductstServices() {
    loadProducts();
  }

  Future<List<Product>> loadProducts() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'products.json');
    final res = await http.get(url);
    final Map<String, dynamic> productsMaps = json.decode(res.body);

    productsMaps.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      productos.add(tempProduct);
    });

    isLoading = false;
    notifyListeners();

    return productos;
  }

  Future saveOrCreateProduct(Product product) async {
    isSaving = true;
    notifyListeners();

    if (product.id == null) {
      await createProduct(product);
    } else {
      await updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products/${product.id}.json');
    final res = await http.put(url, body: product.toJson());
    final decodedData = res.body;

    // set the product with his new information
    final index = productos.indexWhere((element) => element.id == product.id);
    productos[index] = product;

    // todo update list productos
    return product.id ?? decodedData;
  }

  Future<String> createProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products.json');
    final res = await http.post(url, body: product.toJson());
    final decodedData = json.decode(res.body);
    product.id = decodedData['name'];
    productos.add(product);
    return product.id!;
  }

  // todo fetch productos
}
