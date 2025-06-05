import 'package:flutter/material.dart';
import 'package:app_mobile_project/models/filme.dart';

class DetalhesFilmePage extends StatelessWidget {
  final Filme filme;

  DetalhesFilmePage({required this.filme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalhes')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                filme.urlImagem,
                width: 200,
                height: 300,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.error, size: 100, color: Colors.red),
              ),
            ),
            SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    filme.titulo,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 4),
                Text(
                  filme.ano.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: Text(
                    filme.genero,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                Text(
                  filme.faixaEtaria,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${filme.duracao} min',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                Row(
                  children: List.generate(
                    filme.pontuacao.round(),
                    (_) => Icon(Icons.star, color: Colors.amber, size: 20),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              filme.descricao,
              style: TextStyle(fontSize: 16, color: Colors.black),
              ),
          ],
        ),
      ),
    );
  }
}

