import 'package:finance/models/sale_model.dart';
import 'package:finance/repository/sale_repository.dart';
import 'package:flutter/material.dart';

class SaleDetail extends StatefulWidget {
  const SaleDetail({super.key});

  @override
  State<SaleDetail> createState() => _SaleDetailState();
}

class _SaleDetailState extends State<SaleDetail> {
  final saleRepo = SaleRepository();
  SaleModel? saleData;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final sale = await saleRepo.findById("1");
    print("fetch");
    setState(() {
      saleData = sale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sale Detail'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Sale Information
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sale ID:',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${saleData?.id ?? 'Loading...'}',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Cliente:', style: const TextStyle(fontSize: 16)),
                        Text(
                          '${saleData?.person.name ?? 'Loading...'}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pagamento: ',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          '${saleData?.paymentValue ?? 'Loading...'}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tipo de Venda:}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          ' ${saleData?.saleType.name ?? 'Loading...'}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Items Table
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          'Items',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    DataTable(
                      columns: const [
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Quantity')),
                        DataColumn(label: Text('Price')),
                      ],
                      rows:
                          saleData?.movementSales != null
                              ? saleData!.movementSales.map((item) {
                                return DataRow(
                                  cells: [
                                    DataCell(
                                      Text(item.product.name.toString()),
                                    ),
                                    DataCell(Text(item.quantity.toString())),
                                    DataCell(
                                      Text(item.paymentValue.toString()),
                                    ),
                                  ],
                                );
                              }).toList()
                              : [],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
