
import 'package:flutter/material.dart';
import '../models/noticia_model.dart';
import '../services/noticia_service.dart';
import 'detalhe_noticia_screen.dart';

class FeedNoticiasScreen extends StatefulWidget {
  const FeedNoticiasScreen({super.key});

  @override
  State<FeedNoticiasScreen> createState() =>
      _FeedNoticiasScreenState();
}

class _FeedNoticiasScreenState extends State<FeedNoticiasScreen> {
  final NoticiaService _service = NoticiaService();
  final TextEditingController _buscaController =
      TextEditingController();

  late Future<List<NoticiaModel>> _futureNoticias;

  String _termoBusca = '';

  @override
  void initState() {
    super.initState();
    _futureNoticias = _service.buscarNoticias();
  }

  @override
  void dispose() {
    _buscaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portal de Notícias'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _buscaController,
              decoration: InputDecoration(
                hintText: 'Buscar notícia pelo título...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    _buscaController.clear();
                    setState(() {
                      _termoBusca = '';
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (valor) {
                setState(() {
                  _termoBusca = valor.trim().toLowerCase();
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<NoticiaModel>>(
              future: _futureNoticias,
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Erro ao carregar notícias.\n${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                if (!snapshot.hasData ||
                    snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('Nenhuma notícia encontrada.'),
                  );
                }

                final noticias = snapshot.data!
                    .where((noticia) => noticia.titulo
                        .toLowerCase()
                        .contains(_termoBusca))
                    .toList();

                if (noticias.isEmpty) {
                  return const Center(
                    child: Text('Nenhuma notícia encontrada.'),
                  );
                }

                return ListView.builder(
                  itemCount: noticias.length,
                  itemBuilder: (context, index) {
                    final item = noticias[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        title: Text(
                          item.titulo,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(item.resumo),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetalheNoticiaScreen(
                                noticia: item,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
