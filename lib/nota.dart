import 'package:flutter/material.dart';
import 'models/anotacao.dart';
import 'services/storage_service.dart';

class Nota extends StatefulWidget {
  const Nota({super.key});

  @override
  State<Nota> createState() => _NotaState();
}

class _NotaState extends State<Nota> {
  final tituloController = TextEditingController();
  final textoController = TextEditingController();

  final StorageService storageService = StorageService();

  Future<void> salvar() async {
    if (tituloController.text.isEmpty ||
        textoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Preencha o título e a anotação.',
          ),
        ),
      );

      return;
    }

    Anotacao anotacao = Anotacao(
      titulo: tituloController.text,
      texto: textoController.text,
    );

    await storageService.salvarAnotacao(
      anotacao,
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Nota salva com sucesso!',
          ),
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    tituloController.dispose();
    textoController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nova Nota',
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            TextField(
              controller: tituloController,
              decoration: const InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: textoController,
              maxLines: 8,
              decoration: const InputDecoration(
                labelText: 'Anotação',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                onPressed: salvar,

                icon: const Icon(
                  Icons.save,
                ),

                label: const Text(
                  'Salvar nota',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

