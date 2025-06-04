import 'package:finance/models/adress_model.dart';
import 'package:finance/models/interprise_model.dart';
import 'package:finance/models/product_model.dart';
import 'package:finance/models/sale_dto_model.dart';
import 'package:finance/repository/interprise_repository.dart';
import 'package:finance/repository/product_repository.dart';
import 'package:finance/repository/sale_repository.dart';
import 'package:flutter/material.dart';

class SaleScreen extends StatefulWidget {
  const SaleScreen({super.key});

  @override
  _SaleScreenState createState() => _SaleScreenState();
}

class DropdownController<T> extends ValueNotifier<T?> {
  DropdownController(super.value);

  void setValue(T? value) {
    this.value = value;
  }
}

class _SaleScreenState extends State<SaleScreen> {
  final productRepo = ProductRepository();
  final clientRepo = InterpriseRepository(); // Assuming you have a client repo
  final saleRepo = SaleRepository();

  final TextEditingController quantityController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  int? selectedProduct;
  int? selectedClient;
  double price = 0.0;
  double quantity = 1.0;
  double discount = 0.0;

  final List<ProductModel> products = [];
  final List<InterpriseModel> clients = [];

  List<Map<String, dynamic>> chosenProducts = [];

  double get total {
    return chosenProducts.fold(
      0.0,
      (sum, item) =>
          sum +
          (item['price'] * item['quantity']) * (1 - item['discount'] / 100),
    );
  }

  void fetchData() async {
    final productResponse = await productRepo.getAll();
    final clientResponse = await clientRepo.getAll();
    print('started the sale');
    setState(() {
      products.addAll(productResponse);
      clients.addAll(clientResponse);
    });
  }

  void postData() async {
    // Assuming you have a method to post data
    // await productRepo.postData(chosenProducts);
    final saleData = SaleModelDto(
      0,
      total,
      1,
      selectedClient ?? 0,

      chosenProducts
          .map(
            (product) => MovementSaleModelDto(
              product['id'] ?? 0,
              product['product'],
              product['price'],
              product['quantity'],
            ),
          )
          .toList(),
      DateTime.now().toString(),
    );
    print(saleData);
    await saleRepo.createSale(saleData);
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    // Simulate fetching products and clients from a repository
  }

  void addProduct() {
    if (selectedProduct != null && selectedClient != null) {
      setState(() {
        chosenProducts.add({
          'product': selectedProduct,
          'client': selectedClient,
          'price': price,
          'quantity': quantity,
          'discount': discount,
        });
        // Reset fields
        selectedProduct = null;
        price = 0.0;
        quantity = 1;
        discount = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sale Page'), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(23.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<int>(
              decoration: InputDecoration(labelText: 'Select Product'),
              value: selectedProduct,

              items:
                  products
                      .map(
                        (product) => DropdownMenuItem(
                          value: product.id,
                          child: Text(product.name),
                        ),
                      )
                      .toList(),
              onChanged: (value) {
                setState(() {
                  selectedProduct = value;
                });
              },
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<int>(
              decoration: InputDecoration(labelText: 'Select Client'),
              value: selectedClient,
              items:
                  clients
                      .map(
                        (client) => DropdownMenuItem(
                          value: client.id,
                          child: Text(client.name),
                        ),
                      )
                      .toList(),
              onChanged: (value) {
                setState(() {
                  selectedClient = value;
                });
              },
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
              controller: priceController,
              onChanged: (value) {
                setState(() {
                  price = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
              controller: quantityController,
              onChanged: (value) {
                setState(() {
                  quantity = double.tryParse(value) ?? 1;
                });
              },
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(labelText: 'Discount (%)'),
              keyboardType: TextInputType.number,
              controller: discountController,
              onChanged: (value) {
                setState(() {
                  discount = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: addProduct,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                    child: Text('Add Product'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: chosenProducts.length,
                itemBuilder: (context, index) {
                  final product = chosenProducts[index];
                  return Card(
                    color: Colors.blue[50],
                    child: ListTile(
                      title: Text(
                        'Product ID: ${product['product']} - ${product['product'] != null ? products.firstWhere((p) => p.id == product['product']).name : 'Unknown'}',
                        style: TextStyle(color: Colors.blue),
                      ),
                      subtitle: Text(
                        'Price: \$${product['price'].toStringAsFixed(2)}, Quantity: ${product['quantity']}, Discount: ${product['discount']}%',
                        style: TextStyle(color: Colors.red),
                      ),
                      trailing: Text(
                        'Total: \$${((product['price'] * product['quantity']) * (1 - product['discount'] / 100)).toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  );
                },
              ),
            ),
            Divider(),
            Text(
              'Grand Total: \$${total.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            ElevatedButton(onPressed: postData, child: Text('Submit Sale')),
          ],
        ),
      ),
    );
  }
}
