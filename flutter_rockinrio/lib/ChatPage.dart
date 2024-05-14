import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aqui vai ser um Chat'),
      ),
      body: Center(
        child: Text(
          'Chat Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
