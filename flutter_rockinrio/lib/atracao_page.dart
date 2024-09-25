import 'package:flutter/material.dart';
import 'package:flutter_rockinrio/lista_atracoes.dart';

class AtracaoPage extends StatelessWidget {
  final Atracao atracao;
  const AtracaoPage({super.key, required this.atracao});

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
            const SizedBox(height: 20),
            Text(
              atracao.descricao,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
