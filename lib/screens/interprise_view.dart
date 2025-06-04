import 'package:finance/models/adress_model.dart';
import 'package:finance/models/interprise_model.dart';

import 'package:finance/repository/interprise_repository.dart';
import 'package:finance/screens/Interprise.dart';
import 'package:flutter/material.dart';

class InterpriseView extends StatefulWidget {
  const InterpriseView({super.key});

  @override
  State<InterpriseView> createState() => _InterpriseViewState();
}

class _InterpriseViewState extends State<InterpriseView> {
  final interprises = <InterpriseModel>[];
  final _interpriseRepository = InterpriseRepository();

  Future<void> _getData() async {
    try {
      final data = await _interpriseRepository.getAll();

      setState(() {
        interprises.clear();
        interprises.addAll(data);
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
    // You can fetch data from a repository or API here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Empresas'),
        backgroundColor: Colors.blueGrey,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blueGrey),
              child: const Text(
                'Cadastrar',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.new_label),
              title: const Text('Cadastar Empresa'),
              onTap: () {
                Navigator.pushNamed(context, '/new_interprise');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.00),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: DataTableTheme(
                  data: DataTableThemeData(
                    dividerThickness: 0,

                    dataRowColor: WidgetStateProperty.all(Colors.transparent),
                  ),
                  child: DataTable(
                    showBottomBorder: false,
                    columns: const [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Nome')),
                      DataColumn(label: Text('CNPJ')),
                      DataColumn(label: Text('CEP')),
                    ],
                    rows:
                        interprises.map((interprise) {
                          return DataRow(
                            cells: [
                              DataCell(
                                Text(interprise.id.toString()),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => InterpriseForm(
                                            interprise: interprise,
                                          ),
                                    ),
                                  );
                                },
                              ),
                              DataCell(
                                Text(interprise.name),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => InterpriseForm(
                                            interprise: interprise,
                                          ),
                                    ),
                                  );
                                },
                              ),
                              DataCell(
                                Text(interprise.cpf),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => InterpriseForm(
                                            interprise: interprise,
                                          ),
                                    ),
                                  );
                                },
                              ),
                              DataCell(
                                Text(interprise.cep),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => InterpriseForm(
                                            interprise: interprise,
                                          ),
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
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InterpriseForm()),
          );
        },
        tooltip: 'Create Interprise',
        child: Icon(Icons.add),
      ),
    );
  }
}
