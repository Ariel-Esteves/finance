import 'package:finance/models/person_model.dart';
import 'package:finance/repository/person_repository.dart';
import 'package:finance/screens/person_type.dart';
import 'package:flutter/material.dart';

class PersonFormScreen extends StatefulWidget {
  const PersonFormScreen({super.key});

  @override
  _PersonFormScreenState createState() => _PersonFormScreenState();
}

class _PersonFormScreenState extends State<PersonFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cpfController = TextEditingController();
  final _personController = TextEditingController();

  final personRepository = PersonRepository();
  String? _selectedPersonType;

  final List<String> _personTypes = [
    'Student',
    'Employee',
    'Freelancer',
    'Other',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _cpfController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Process the form data
      final name = _nameController.text;
      final cpf = _cpfController.text;
      final personType = _selectedPersonType;
      final person = _personController.text;

      final model = PersonModel(
        0, // id
        cpf, // cpf
        name, // name
        _selectedPersonType!,
        person, // personType
      );

      print('Name: $name');
      print('Email: $cpf');
      print('Person Type: $personType');
      personRepository.insert(model);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Person Information Form')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Relacionados',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.type_specimen),
              title: Text('Person Types'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PersonTypeScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _cpfController,
                  decoration: InputDecoration(labelText: 'Cpf'),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedPersonType,
                  decoration: InputDecoration(labelText: 'Person Type'),
                  items:
                      _personTypes.map((type) {
                        return DropdownMenuItem(value: type, child: Text(type));
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedPersonType = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a person type';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PersonFormScreen()),
          );
        },
        tooltip: 'Create Product',
        child: Icon(Icons.add),
      ),
    );
  }
}
