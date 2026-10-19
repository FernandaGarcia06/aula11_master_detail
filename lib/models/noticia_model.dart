
class NoticiaModel {
  final int id;
  final String titulo;
  final String resumo;
  final String conteudoCompleto;
  final String autor;
  final String urlImagem;

  NoticiaModel({
    required this.id,
    required this.titulo,
    required this.resumo,
    required this.conteudoCompleto,
    required this.autor,
    required this.urlImagem,
  });

  factory NoticiaModel.fromJson(Map<String, dynamic> json) {
    final String conteudo = json['body'] ?? '';
    final String resumo = conteudo.length > 40
        ? '${conteudo.substring(0, 40)}...'
        : conteudo;

    return NoticiaModel(
      id: json['id'] ?? 0,
      titulo: json['title'] ?? 'Sem título',
      resumo: resumo,
      conteudoCompleto: conteudo.isEmpty
          ? 'Sem conteúdo disponível.'
          : conteudo,
      autor: 'Autor ID ${json['userId'] ?? 1}',
      urlImagem: 'https://picsum.photos/seed/${json['id'] ?? 1}/800/400',
    );
  }
}
