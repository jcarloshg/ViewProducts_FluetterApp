import 'dart:convert';

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
    final isValidForm = formKey.currentState?.validate() ?? false;
    print('$isValidForm');
    return isValidForm;
  }
}
