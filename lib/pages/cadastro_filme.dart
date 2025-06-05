import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:app_mobile_project/models/filme.dart';
import 'package:app_mobile_project/database/filme_db.dart';

class CadastroFilmePage extends StatefulWidget {
  final Filme? filme;

  CadastroFilmePage({this.filme});

  @override
  _CadastroFilmePageState createState() => _CadastroFilmePageState();
}

class _CadastroFilmePageState extends State<CadastroFilmePage> {
  final _formKey = GlobalKey<FormState>();
  final _urlImagemController = TextEditingController();
  final _tituloController = TextEditingController();
  final _generoController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _duracaoController = TextEditingController();
  final _anoController = TextEditingController();
  double _pontuacao = 0.0;
  String _faixaEtaria = 'Livre';

  final List<String> _faixas = ['Livre', '10', '12', '14', '16', '18'];

  @override
  void initState() {
    super.initState();
    if (widget.filme != null) {
      _urlImagemController.text = widget.filme!.urlImagem;
      _tituloController.text = widget.filme!.titulo;
      _generoController.text = widget.filme!.genero;
      _faixaEtaria = widget.filme!.faixaEtaria;
      _duracaoController.text = widget.filme!.duracao.toString();
      _pontuacao = widget.filme!.pontuacao;
      _anoController.text = widget.filme!.ano.toString();
      _descricaoController.text = widget.filme!.descricao;
    }
  }

  void _salvarFilme() async {
    if (_formKey.currentState!.validate()) {
      Filme novoFilme = Filme(
        id: widget.filme?.id,
        urlImagem: _urlImagemController.text,
        titulo: _tituloController.text,
        genero: _generoController.text,
        faixaEtaria: _faixaEtaria,
        duracao: int.parse(_duracaoController.text),
        pontuacao: _pontuacao,
        ano: int.parse(_anoController.text),
        descricao: _descricaoController.text,
      );

      if (widget.filme == null) {
        await FilmeDB.insertFilme(novoFilme);
      } else {
        await FilmeDB.updateFilme(novoFilme);
      }

      Navigator.pop(context, true);
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(widget.filme == null ? 'Cadastrar Filme' : 'Editar Filme'),
    ),
    body: Padding(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: _urlImagemController,
              decoration: InputDecoration(labelText: 'URL da Imagem'),
              validator: (value) => value!.isEmpty ? 'Informe a URL da imagem' : null,
            ),
            TextFormField(
              controller: _tituloController,
              decoration: InputDecoration(labelText: 'Título'),
              validator: (value) => value!.isEmpty ? 'Informe o título' : null,
            ),
            TextFormField(
              controller: _generoController,
              decoration: InputDecoration(labelText: 'Gênero'),
              validator: (value) => value!.isEmpty ? 'Informe o gênero' : null,
            ),
            DropdownButtonFormField(
              value: _faixaEtaria,
              items: _faixas.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (val) => setState(() => _faixaEtaria = val.toString()),
              decoration: InputDecoration(labelText: 'Faixa Etária'),
            ),
            TextFormField(
              controller: _duracaoController,
              decoration: InputDecoration(labelText: 'Duração'),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? 'Informe a duração' : null,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  const Text(
                    'Nota:',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 8),
                  SmoothStarRating(
                    allowHalfRating: true,
                    starCount: 5,
                    rating: _pontuacao,
                    size: 30,
                    color: Colors.blue,
                    onRatingChanged: (val) => setState(() => _pontuacao = val),
                  ),
                ],
              ),
            ),
            TextFormField(
              controller: _anoController,
              decoration: InputDecoration(labelText: 'Ano'),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? 'Informe o ano' : null,
            ),
            TextFormField(
              controller: _descricaoController,
              decoration: InputDecoration(labelText: 'Descrição'),
              maxLines: 3,
              validator: (value) => value!.isEmpty ? 'Informe a descrição' : null,
            ),
            SizedBox(height: 80), // Espaço extra pro botão flutuante não sobrepor campos
          ],
        ),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: _salvarFilme,
      backgroundColor: Colors.blue,
      child: Icon(Icons.save),
    ),
  );
}
}