import 'package:flutter/material.dart';
import 'package:flutter_rockinrio/RegisterPage.dart';
import 'database_helper.dart';

class LoginPage extends StatelessWidget {
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
                    // Navegar para outra tela, se necessário
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email ou senha inválidos')));
                  }
                },
                child: Text('Login'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterPage()));
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
