import 'package:finance/models/person_type_model.dart';
import 'package:finance/repository/person_repository.dart';
import 'package:flutter/material.dart';

class PersonTypeScreen extends StatefulWidget {
  const PersonTypeScreen({super.key});

  @override
  State<PersonTypeScreen> createState() => _PersonTypeScreenState();
}

class _PersonTypeScreenState extends State<PersonTypeScreen> {
  final _typeController = TextEditingController();

  void sendForm() {
    final type = _typeController.text;
    PersonTypeModel personTypeModel = PersonTypeModel(name: type);
    if (type.isNotEmpty) {
      PersonRepository().insertType(personTypeModel);
    } else {
      // Handle empty input
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a person type.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Person Type')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 16.00),
              TextFormField(
                controller: _typeController,
                decoration: const InputDecoration(labelText: 'Person Type'),
              ),
              ElevatedButton(
                onPressed: () {
                  sendForm();
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
