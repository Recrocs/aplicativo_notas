import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/anotacao.dart';

class StorageService {
  Future<void> salvarAnotacao(Anotacao anotacao) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> anotacoesSalvas =
        prefs.getStringList('anotacoes') ?? [];

    anotacoesSalvas.add(
      jsonEncode(anotacao.toMap()),
    );

    await prefs.setStringList(
      'anotacoes',
      anotacoesSalvas,
    );
  }

  Future<List<Anotacao>> buscarAnotacoes() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> anotacoesSalvas =
        prefs.getStringList('anotacoes') ?? [];

    List<Anotacao> anotacoes = [];

    for (String anotacaoSalva in anotacoesSalvas) {
      Map<String, dynamic> dados =
          jsonDecode(anotacaoSalva);

      anotacoes.add(
        Anotacao.fromMap(dados),
      );
    }

    return anotacoes;
  }
}