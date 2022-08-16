import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String? url;

  const ProductImage({this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 45),
      child: Container(
        decoration: _boxDecoration(),
        width: double.infinity,
        height: 450,
        child: Opacity(
          opacity: 0.8,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            child: url == null || url == ''
                ? const Image(
                    image: AssetImage('assets/not_image.jpeg'),
                    fit: BoxFit.scaleDown,
                  )
                : FadeInImage(
                    placeholder: const AssetImage('assets/loading.gif'),
                    image: NetworkImage(url!),
                    fit: BoxFit.contain,
                  ),
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
      color: Colors.black,
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
