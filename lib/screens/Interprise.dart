import 'package:finance/http/image_selector.dart';
import 'package:finance/models/adress_model.dart';
import 'package:finance/models/interprise_model.dart';
import 'package:finance/repository/cep_repository.dart';
import 'package:finance/repository/interprise_repository.dart';

import 'package:flutter/material.dart';

class InterpriseForm extends StatefulWidget {
  final InterpriseModel? interprise;
  const InterpriseForm({super.key, this.interprise});
  @override
  _InterpriseFormState createState() => _InterpriseFormState();
}

class _InterpriseFormState extends State<InterpriseForm> {
  final _formKey = GlobalKey<FormState>();
  final CepRepository _cepRepository = CepRepository();
  final InterpriseRepository _interpriseRepository =
      InterpriseRepository(); // Initialize the repository
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _cnpjController = TextEditingController();
  final TextEditingController _ufController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  String? _imagePath;
  int _currentStep = 0; // Track the current step in the form

  @override
  void initState() {
    super.initState();
    if (widget.interprise != null) {
      _nameController.text = widget.interprise?.name ?? '';
      _cnpjController.text = widget.interprise?.cpf ?? '';
      _cepController.text = widget.interprise?.cep ?? '';
      _streetController.text = widget.interprise?.address?.street ?? '';
      _cityController.text = widget.interprise?.address?.city ?? '';
      _ufController.text = widget.interprise?.address?.uf ?? '';
      _countryController.text = widget.interprise?.address?.country ?? '';
      _numberController.text =
          widget.interprise?.address?.number.toString() ?? '';
    }
  }

  Future<void> _getCep() async {
    final response = await _cepRepository.getByCep(
      _cepController.text,
    ); // Call the repository to fetch data
    setState(() {
      _streetController.text = response.street;
      _cityController.text = response.city;
      _ufController.text = response.uf;
      _countryController.text = response.country;
    });
  }

  Future<void> post() async {
    final address = AddressModel(
      id: 0,
      cep: _cepController.text,
      street: _streetController.text,
      city: _cityController.text,
      uf: _ufController.text,
      country: _countryController.text,
      number: int.parse(_numberController.text),
      neighborhood: '',
    );
    final interprise = InterpriseModel(
      name: _nameController.text,
      cpf: _cnpjController.text,
      cep: _cepController.text,
      address: address,
    );
    final response = await _interpriseRepository.create(interprise);
    print(response);
  }

  Future<void> _pickAndSaveImage() async {
    final uploader = ImageUploader();
    final path = await uploader.saveImageFromGalleryLocally();
    if (path != null) {
      setState(() {
        _imagePath = path;
      });
    }
  }

  List<Step> get _steps => [
    Step(
      title: Text("Interprise Name"),
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Enterprise Name',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
              ),

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the enterprise name';
                }
                return null;
              },
            ),
          ),
        ],
      ),
      isActive: _currentStep == 0,
    ),
    Step(
      title: Text("Cep"),
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TextFormField(
          controller: _cepController,
          decoration: InputDecoration(
            labelText: 'Cep',
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter the Cep';
            }
            if (value.length != 8) {
              return 'Cep must be 8 characters long';
            }
            return null;
          },
          onChanged: (value) {
            if (value.length == 8) {
              _getCep(); // Call the _getCep method when the length is 8
            }
          },
        ),
      ),
      isActive: _currentStep == 1,
    ),
    Step(
      title: Text("Confirme o Endereço"),
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              controller: _cnpjController,
              decoration: InputDecoration(
                labelText: 'cnpj',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the Cep';
                }
                return null;
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              controller: _ufController,
              decoration: InputDecoration(
                labelText: 'UF',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the UF';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              controller: _streetController,
              decoration: InputDecoration(
                labelText: 'Street',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the street';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'City',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the city';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              controller: _countryController,
              decoration: InputDecoration(
                labelText: 'Country',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the country';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              controller: _numberController,
              decoration: InputDecoration(
                labelText: 'Number',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the number';
                }
                if (int.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
          ),
        ],
      ),
      isActive: _currentStep <= 2,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enterprise Information')),
      body: Form(
        key: _formKey,
        child: Stepper(
          type: StepperType.vertical,
          currentStep: _currentStep,
          steps: _steps,
          onStepContinue: () async {
            if (_currentStep < _steps.length - 1) {
              setState(() => _currentStep += 1);
            } else {
              await post();

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Empresa cadastrada com sucesso!'),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
