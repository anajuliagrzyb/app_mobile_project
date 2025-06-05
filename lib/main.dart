import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:app_mobile_project/models/filme.dart';
import 'package:app_mobile_project/database/filme_db.dart';
import 'package:app_mobile_project/pages/cadastro_filme.dart';
import 'package:app_mobile_project/pages/detalhes_filme.dart';

void main() {
  runApp(FilmesApp());
}

class FilmesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Filmes TV',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      home: ListaFilmesPage(),
    );
  }
}

class ListaFilmesPage extends StatefulWidget {
  @override
  _ListaFilmesPageState createState() => _ListaFilmesPageState();
}

class _ListaFilmesPageState extends State<ListaFilmesPage> {
  List<Filme> filmes = [];

  @override
  void initState() {
    super.initState();
    _carregarFilmes();
  }

  Future<void> _carregarFilmes() async {
    final lista = await FilmeDB.getFilmes();
    setState(() {
      filmes = lista;
    });
  }

  void _mostrarAlerta(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Grupo'),
        content: Text('Nome dos integrantes: Fátima, Ana Julia e Patrick'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _abrirCadastro([Filme? filme]) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CadastroFilmePage(filme: filme),
      ),
    );
    if (resultado == true) _carregarFilmes();
  }

  void _mostrarOpcoes(Filme filme) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(
        children: [
          ListTile(
            leading: Icon(Icons.visibility),
            title: Text('Exibir Dados'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DetalhesFilmePage(filme: filme)),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Alterar'),
            onTap: () {
              Navigator.pop(context);
              _abrirCadastro(filme);
            },
          ),
        ],
      ),
    );
  }

  void _deletarFilme(int id) async {
    await FilmeDB.deleteFilme(id);
    _carregarFilmes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filmes'),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () => _mostrarAlerta(context),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filmes.length,
        itemBuilder: (context, index) {
          final filme = filmes[index];
          return Dismissible(
            key: Key(filme.id.toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (_) => _deletarFilme(filme.id!),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              child: InkWell(
                onTap: () => _mostrarOpcoes(filme),
                child: Container(
                  padding: EdgeInsets.all(12),
                  height: 160,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          filme.urlImagem,
                          width: 100,
                          height: 140,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                width: 100,
                                height: 140,
                                color: Colors.grey[300],
                                child: Icon(Icons.broken_image, size: 40),
                              ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              filme.titulo,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Text(filme.genero),
                            Text('${filme.duracao} min'),
                            SizedBox(height: 8),
                            RatingBarIndicator(
                              rating: filme.pontuacao,
                              itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
                              itemCount: 5,
                              itemSize: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _abrirCadastro(),
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.blue,
        tooltip: 'Cadastrar novo filme',
      ),
    );
  }
}
