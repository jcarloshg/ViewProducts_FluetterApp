import 'package:flutter/material.dart';
import 'package:forms_validators/models/models.index.dart';

class ProductFormProviders extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Product product;

  ProductFormProviders(this.product);

  updateAvailable(bool value) {
    product.available = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
