import 'package:flutter/material.dart';
import 'package:flutter_rockinrio/atracao_page.dart';
import 'package:flutter_rockinrio/lista_atracoes.dart';
import 'package:flutter_rockinrio/LoginPage.dart';
import 'package:flutter_rockinrio/AboutPage.dart';
import 'package:flutter_rockinrio/ChatPage.dart';
import 'package:flutter_rockinrio/RegisterPage.dart';
import 'package:flutter_rockinrio/database_helper.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Atracao> _listaFavoritos = [];
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    LoginPage(), // Página de Login
    ChatPage(), // Página de Chat
    AboutPage(), // Página "Sobre"
  ];

  bool _isAuthenticated = false; // Variável para verificar se o usuário está autenticado

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    // Substitua os valores null pelo email e senha do usuário autenticado, se disponíveis.
    Map<String, dynamic>? user = await DatabaseHelper().authenticateUser("email", "password");
    if (user != null) {
      setState(() {
        _isAuthenticated = true;
      });
    } else {
      setState(() {
        _isAuthenticated = false;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isAuthenticated) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Atrações'),
          backgroundColor: Colors.blue,
          actions: [
            Image.asset(
              'assets/image1.png',
              height: 40,
            )
          ],
        ),
        body: ListView.builder(
          itemCount: listaAtracoes.length,
          itemBuilder: (context, index) {
            final isFavorito = _listaFavoritos.contains(listaAtracoes[index]);
            return ListTile(
              title: Text(listaAtracoes[index].nome),
              subtitle: Wrap(
                spacing: 8,
                runSpacing: 4,
                children: listaAtracoes[index]
                    .tags
                    .map((tag) => Chip(label: Text('#$tag')))
                    .toList(),
              ),
              leading: CircleAvatar(
                child: Text('${listaAtracoes[index].dia}'),
              ),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    if (isFavorito) {
                      _listaFavoritos.remove(listaAtracoes[index]);
                    } else {
                      _listaFavoritos.add(listaAtracoes[index]);
                    }
                  });
                },
                icon: isFavorito
                    ? const Icon(
                  Icons.favorite,
                  color: Colors.red,
                )
                    : const Icon(Icons.favorite_border),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AtracaoPage(atracao: listaAtracoes[index]),
                  ),
                );
              },
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.login),
              label: 'Login',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'Sobre',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
        ),
      );
    } else {
      return LoginPage();
    }
  }
}
