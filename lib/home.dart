import 'package:flutter/material.dart';
import 'models/anotacao.dart';
import 'services/storage_service.dart';
import 'nota.dart';
import 'theme_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Anotacao> anotacoes = [];

  final StorageService storageService = StorageService();

  @override
  void initState() {
    super.initState();

    carregarAnotacoes();
  }

  Future<void> carregarAnotacoes() async {
    List<Anotacao> lista =
        await storageService.buscarAnotacoes();

    setState(() {
      anotacoes = lista;
    });
  }

  Future<void> abrirNota() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Nota(),
      ),
    );

    carregarAnotacoes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Minhas Notas',
        ),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.note_alt,
                    size: 50,
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Aplicativo de Notas',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text(
                'Início',
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ValueListenableBuilder<bool>(
              valueListenable: temaEscuro,
              builder: (context, escuro, child) {
                return ListTile(
                  leading: Icon(
                    escuro
                        ? Icons.light_mode
                        : Icons.dark_mode,
                  ),

                  title: Text(
                    escuro
                        ? 'Modo claro'
                        : 'Modo escuro',
                  ),

                  onTap: () {
                    trocarTema();

                    Navigator.pop(context);
                  },
                );
              },
            ),

            ListTile(
              leading: const Icon(
                Icons.add,
              ),
              title: const Text(
                'Nova nota',
              ),
              onTap: () {
                Navigator.pop(context);

                abrirNota();
              },
            ),
          ],
        ),
      ),

      body: anotacoes.isEmpty
          ? const Center(
              child: Text(
                'Nenhuma nota cadastrada.',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: anotacoes.length,
              itemBuilder: (context, index) {
                Anotacao anotacao =
                    anotacoes[index];

                return Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(
                        Icons.note,
                      ),
                    ),

                    title: Text(
                      anotacao.titulo,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    subtitle: Text(
                      anotacao.texto,
                    ),
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: abrirNota,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}

