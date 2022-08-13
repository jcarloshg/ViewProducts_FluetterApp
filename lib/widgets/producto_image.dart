import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: _boxDecoration(),
        width: double.infinity,
        height: 450,
        child: const ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: FadeInImage(
            placeholder: AssetImage('assets/loading.gif'),
            image: NetworkImage(
              'https://via.placeholder.com/400x300/green',
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      color: Colors.red,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 10,
          offset: const Offset(0, 15),
        )
      ],
    );
  }
}
