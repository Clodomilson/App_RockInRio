import 'package:flutter/material.dart';
import 'package:flutter_rockinrio/database_helper.dart';
import 'package:flutter_rockinrio/HomePage.dart';
import 'package:flutter_rockinrio/RegisterPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLogin = true;

  void _toggleFormMode() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  void _submit() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    print('email:  $email');
    print('senha:  $password');
    bool success;
    if (_isLogin) {
      success = await _login(email, password);
      if (success) {
        print('Login bem-sucedido, redirecionando para HomePage');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(loggedInUserEmail: email)),
        );
      }
    } else {
      final name = _nameController.text;
      final phone = _phoneController.text;
      success = await _register(name, email, phone, password);
      if (success) {
        print('Cadastro bem-sucedido, redirecionando para HomePage');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(loggedInUserEmail: email)),
        );
      }
    }
    if (!success) {
      print('Autenticação falhou');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Authentication failed')));
    }
  }

  Future<bool> _login(String email, String password) async {
    final user = await DatabaseHelper().getUser(email, password);
    print('Usuário encontrado: $user');
    return user != null;
  }

  Future<bool> _register(
      String name, String email, String phone, String password) async {
    try {
      await DatabaseHelper().insertUser({
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      });
      return true;
    } catch (e) {
      print('Erro ao cadastrar: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLogin ? 'Login' : 'Register'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!_isLogin)
                Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Telefone',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text(_isLogin ? 'Login' : 'Register'),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: _toggleFormMode,
                child: Text(_isLogin
                    ? 'Não tem uma conta? Cadastre-se'
                    : 'Já tem uma conta? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
