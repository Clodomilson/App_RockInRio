import 'package:flutter/material.dart';
import 'package:flutter_rockinrio/lista_atracoes.dart';

class AtracaoPage extends StatelessWidget {
  final Atracao atracao;
  AtracaoPage({Key? key, required this.atracao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(atracao.nome),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              atracao.imagem,
              height: 200,
              width: 200,
            ),
            SizedBox(height: 20),
            Text(
              atracao.descricao,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
