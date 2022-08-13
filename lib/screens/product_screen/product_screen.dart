import 'package:flutter/material.dart';
import 'package:forms_validators/UI/inputs_decorations.dart';
import 'package:forms_validators/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.save_as,
          size: 40,
        ),
        onPressed: () => {},
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(),
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
    );
  }
}

class _FormProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        width: double.infinity,
        decoration: _builtBoxDecoratioon(),
        child: Form(
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputsDecorations.authInputDecoration(
                  hintText: "nombre",
                  labelText: "Nomnbre del producto",
                ),
              ),
              TextFormField(
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
                value: true,
                onChanged: (value) => {},
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
