class Anotacao {
  String titulo;
  String texto;

  Anotacao({
    required this.titulo,
    required this.texto,
  });

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'texto': texto,
    };
  }

  factory Anotacao.fromMap(Map<String, dynamic> map) {
    return Anotacao(
      titulo: map['titulo'],
      texto: map['texto'],
    );
  }
}