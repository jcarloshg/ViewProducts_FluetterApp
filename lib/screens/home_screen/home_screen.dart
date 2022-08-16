import 'package:flutter/material.dart';
import 'package:forms_validators/screens/home_screen/widgets/widgets.dart';
import 'package:forms_validators/screens/screens.dart';
import 'package:forms_validators/services/services.index.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productstServices = Provider.of<ProductstServices>(context);

    if (productstServices.isLoading == true) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      body: ListView.builder(
        itemCount: productstServices.productos.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () {
            productstServices.selectedProduct =
                productstServices.productos[index].copyProduct();
            Navigator.pushNamed(context, 'productScreen');
          },
          child: ProductCard(product: productstServices.productos[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
