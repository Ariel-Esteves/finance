import 'package:finance/components/snack.dart';
import 'package:finance/models/product_model.dart';
import 'package:finance/repository/product_repository.dart';
import 'package:flutter/material.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  _CreateProductScreenState createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final ProductRepository productRepository;
  _CreateProductScreenState() : productRepository = ProductRepository();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final productModel = ProductModel(
      id: 0,
      name: nameController.text,
      description: priceController.text,
      price:
          priceController.text.isNotEmpty
              ? double.parse(priceController.text)
              : 0.0,
      stock: double.tryParse(quantityController.text) ?? 0.0,
    );
    return Scaffold(
      appBar: AppBar(title: Text('Create Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Product Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a product name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: priceController,
                  decoration: InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: quantityController,
                  decoration: InputDecoration(labelText: 'Quantidade'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a product quantity';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),

                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final productModel = ProductModel(
                        id: 0,
                        name: nameController.text,
                        description: descriptionController.text,
                        price:
                            priceController.text.isNotEmpty
                                ? double.parse(priceController.text)
                                : 0.0,
                      );
                      print('Product: ${productModel.toMap()}');
                      productRepository.insert(productModel);
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(Snacks.success());
                    }
                  },
                  child: Text('Save Product'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
