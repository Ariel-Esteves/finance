import 'package:finance/models/product_model.dart';
import 'package:finance/repository/product_repository.dart';
import 'package:finance/screens/product.dart';
import 'package:finance/screens/product_view.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final products = <ProductModel>[];
  final _productRepository = ProductRepository();
  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      final fetchedProducts = await _productRepository.getAll();

      setState(() {
        products.clear(); // Clear the list before adding new items
        products.addAll(fetchedProducts);
      });
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product List')),

      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].name),
            leading: Icon(Icons.shopping_cart),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ProductView(
                        product: products[index],

                        //id: products[index].id,
                      ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateProductScreen()),
          );
        },
        tooltip: 'Create Product',
        child: Icon(Icons.add),
      ),
    );
  }
}
