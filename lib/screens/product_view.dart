import 'package:finance/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductView extends StatefulWidget {
  final ProductModel product;

  const ProductView({super.key, required this.product});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product View')),
      body: Center(
        child: Center(
          child: Column(
            children: [
              Text(
                widget.product.name,
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.product.description,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.deepPurpleAccent.shade200,
                  fontWeight: FontWeight.w600,
                ),
              ),

              Text(
                'Price: ${widget.product.price}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.deepPurpleAccent.shade400,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Stock: ${widget.product.stock}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.deepPurpleAccent.shade400,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
