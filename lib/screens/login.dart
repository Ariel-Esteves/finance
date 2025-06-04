import 'package:finance/cfg/security.dart';
import 'package:finance/models/user_model.dart';
import 'package:finance/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class LoginScreen extends StatefulWidget {
  final UserRepository userRepository = UserRepository();
  final token = TokenStorage();
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: TokenStorage().isTokenValid(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData && snapshot.data == true) {
          // Navigate to home after build is complete
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              Navigator.pushReplacementNamed(context, '/home');
            }
          });
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        // If token is not valid, show login form
        return Scaffold(
          appBar: AppBar(title: Text('Login')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                    'https://www.viainox.com/upload/produto/imagem/panela-tramontina-lyon-em-alum-nio-com-revestimento-starflon-azul-elementar-20cm.webp',
                  ),
                ),
                TextField(
                  onChanged: (value) => debugPrint(usernameController.text),
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  obscureText: _obscurePassword,
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () async {
                    if (usernameController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please enter username and password'),
                        ),
                      );
                      return;
                    }
                    final user = UserModel(
                      login: usernameController.text,
                      password: passwordController.text,
                    );
                    final response = await widget.userRepository.login(user);
                    if (response != null) {
                      // Handle successful login
                      Navigator.pushReplacementNamed(context, '/home');
                    } else {
                      // Handle login error
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Login failed. Please try again.'),
                        ),
                      );
                    }
                  },
                  child: Text('Login'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Text('Don\'t have an account? Sign up'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
