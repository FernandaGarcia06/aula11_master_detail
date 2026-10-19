
import 'package:flutter/material.dart';
import '../models/noticia_model.dart';

class DetalheNoticiaScreen extends StatelessWidget {
  final NoticiaModel noticia;

  const DetalheNoticiaScreen({
    super.key,
    required this.noticia,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Notícia'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              noticia.urlImagem,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.grey.shade300,
                  child: const Icon(
                    Icons.image,
                    size: 50,
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Chip(
                    avatar: const Icon(Icons.person, size: 18),
                    label: Text(noticia.autor),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    noticia.titulo,
                    style: Theme.of(context)
                        .textTheme.headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Divider(height: 32),
                  Text(
                    noticia.conteudoCompleto,
                    style: Theme.of(context)
                        .textTheme.bodyLarge
                        ?.copyWith(height: 1.5),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'ID da notícia: ${noticia.id}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
