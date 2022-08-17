import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forms_validators/UI/inputs_decorations.dart';
import 'package:forms_validators/providers/providers.index.dart';
import 'package:forms_validators/services/services.index.dart';
import 'package:forms_validators/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productstServices = Provider.of<ProductstServices>(context);

    return ChangeNotifierProvider(
      create: (_) => ProductFormProviders(productstServices.selectedProduct),
      child: _ProductScreenBody(productstServices: productstServices),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productstServices,
  }) : super(key: key);

  final ProductstServices productstServices;

  @override
  Widget build(BuildContext context) {
    final productFormProviders = Provider.of<ProductFormProviders>(context);

    return Scaffold(
      body: SingleChildScrollView(
        // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(url: productstServices.selectedProduct.picture),
                Positioned(
                  top: 60,
                  left: 40,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
                Positioned(
                  top: 60,
                  right: 40,
                  child: IconButton(
                    onPressed: () {
                      // TODO gallery
                    },
                    icon: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ],
            ),
            _FormProduct(),
            const SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.save_as_rounded,
          size: 40,
        ),
        onPressed: () async {
          if (productFormProviders.isValidForm() == false) return;
          await productstServices
              .saveOrCreateProduct(productFormProviders.product);
        },
      ),
    );
  }
}

class _FormProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productFormProviders = Provider.of<ProductFormProviders>(context);
    final product = productFormProviders.product;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        width: double.infinity,
        decoration: _builtBoxDecoratioon(),
        child: Form(
          key: productFormProviders.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextFormField(
                initialValue: product.name,
                onChanged: (value) => product.name = value,
                validator: (value) {
                  return (value == null || value == '')
                      ? 'El nombre es obligatorio'
                      : null;
                },
                decoration: InputsDecorations.authInputDecoration(
                  hintText: "nombre",
                  labelText: "Nomnbre del producto",
                ),
              ),
              TextFormField(
                initialValue: '${product.price}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: (value) {
                  final newValue = double.tryParse(value) ?? 0.0;
                  product.price = newValue;
                },
                keyboardType: TextInputType.number,
                decoration: InputsDecorations.authInputDecoration(
                  hintText: "\$150",
                  labelText: "Precio",
                ),
              ),
              const SizedBox(height: 10),
              SwitchListTile.adaptive(
                title: const Text('Disponible'),
                activeColor: Colors.indigo,
                value: product.available,
                onChanged: productFormProviders.updateAvailable,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _builtBoxDecoratioon() => BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 5),
            blurRadius: 5,
          ),
        ],
      );
}
