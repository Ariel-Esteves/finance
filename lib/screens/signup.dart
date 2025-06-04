import 'package:finance/cfg/security.dart';
import 'package:finance/models/person_model.dart';
import 'package:finance/models/user_model.dart';
import 'package:finance/repository/person_repository.dart';
import 'package:finance/repository/user_repository.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => SignupState();
}

class SignupState extends State<Signup> {
  int _currentStep = 0;
  final userRepository = UserRepository();
  final personRepository = PersonRepository();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();

  Future _sendForm() async {
    final user = UserModel(
      login: usernameController.text,
      password: passwordController.text,
      token: ' ',
    );
    //final responseUser = await userRepository.insert(user);
    /*  PersonModel(this._id, this._name, this._cpf, this._personType, this._user);*/
    final person = PersonModel(
      0,
      _nameController.text,
      _cpfController.text,
      'user',
      usernameController.text,
    );
    print(person.toMap());

    final responseUser = await userRepository.insert(user);
    final responsePerson = await personRepository.insert(person);
  }

  @override
  void initState() {
    TokenStorage().deleteToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Stepper(
          currentStep: _currentStep,
          onStepContinue: () {
            if (_currentStep < 1) {
              setState(() {
                _currentStep += 1;
              });
            } else {
              _sendForm();
              Navigator.pushReplacementNamed(context, '/home');
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() {
                _currentStep -= 1;
              });
            } else {}
          },
          steps: [
            Step(
              title: Text("Crie um usuário e senha"),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    onChanged: (value) => debugPrint(usernameController.text),
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
            Step(
              title: Text('informações básicas'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
