import 'package:flutter/material.dart';
import 'package:flutter_rockinrio/database_helper.dart';
import 'package:flutter_rockinrio/HomePage.dart'; // Importe a página principal aqui
import 'package:flutter_rockinrio/RegisterPage.dart'; // Importe a página de cadastro aqui

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                onPressed: () async {
                  var user = await DatabaseHelper().authenticateUser(
                    _emailController.text,
                    _passwordController.text,
                  );
                  if (user != null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login realizado com sucesso!')));
                    // Navegar para a página principal após o login
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()), // Substitua 'HomePage()' pela sua página principal
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email ou senha inválidos')));
                  }
                },
                child: Text('Login'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: Text('Cadastre-se'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
