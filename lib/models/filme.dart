class Filme {
  int? id;
  String titulo;
  String genero;
  String urlImagem;
  String faixaEtaria;
  String descricao;
  int duracao; // em minutos
  double pontuacao;
  int ano;

  Filme({
    this.id,
    required this.titulo,
    required this.genero,
    required this.urlImagem,
    required this.faixaEtaria,
    required this.descricao,
    required this.duracao,
    required this.pontuacao,
    required this.ano,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'genero': genero,
      'urlImagem': urlImagem,
      'faixaEtaria': faixaEtaria,
      'descricao': descricao,
      'duracao': duracao,
      'pontuacao': pontuacao,
      'ano': ano,
    };
  }

  static Filme fromMap(Map<String, dynamic> map) {
    return Filme(
      id: map['id'],
      titulo: map['titulo'],
      genero: map['genero'],
      urlImagem: map['urlImagem'],
      faixaEtaria: map['faixaEtaria'],
      descricao: map['descricao'],
      duracao: map['duracao'],
      pontuacao: map['pontuacao'],
      ano: map['ano'],
    );
  }
}
