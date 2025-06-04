import 'package:finance/models/sale_dto_model.dart';
import 'package:finance/repository/sale_repository.dart';
import 'package:finance/screens/sale.dart';
import 'package:finance/screens/sale_detail.dart';
import 'package:flutter/material.dart';

class SaleView extends StatefulWidget {
  const SaleView({super.key});

  @override
  State<SaleView> createState() => _SaleViewState();
}

class _SaleViewState extends State<SaleView> {
  final saleRepo = SaleRepository();
  List<SaleModelDto> SaleList = [];

  void fetchData() async {
    final sales = await saleRepo.getAll();
    setState(() {
      SaleList.addAll(sales);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales List'),
        backgroundColor: Colors.blueGrey,
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.new_label),
              title: const Text('New Sale'),
              onTap: () {
                Navigator.pushNamed(context, '/new_sale');
              },
            ),
          ],
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Total')),
              DataColumn(label: Text('Date')),
            ],
            rows:
                SaleList.map((sale) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Text('${sale.id}'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SaleDetail(),
                            ),
                          );
                        },
                      ),
                      DataCell(
                        Text('${sale.paymentValue}'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SaleDetail(),
                            ),
                          );
                        },
                      ),
                      DataCell(
                        Text('${sale.dateValue}'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SaleDetail(),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/new_sale');
        },
        tooltip: 'Create Product',
        child: const Icon(Icons.add),
      ),
    );
  }
}
