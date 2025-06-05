import 'package:flutter/material.dart';
import 'package:app_mobile_project/models/filme.dart';

class DetalhesFilmePage extends StatelessWidget {
  final Filme filme;

  DetalhesFilmePage({required this.filme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(filme.titulo)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Image.network(
              filme.urlImagem,
              width: 100,
              height: 150,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.error, size: 100, color: Colors.red),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Gênero: ${filme.genero}', style: TextStyle(fontSize: 16)),
                  Text('Faixa Etária: ${filme.faixaEtaria}'),
                  Text('Duração: ${filme.duracao} min'),
                  Text('Pontuação: ${filme.pontuacao}'),
                  Text('Ano: ${filme.ano}'),
                  SizedBox(height: 10),
                  Text('Descrição:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(filme.descricao, maxLines: 8, overflow: TextOverflow.ellipsis),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
