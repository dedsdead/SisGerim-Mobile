class Caracteristica {
  final String id;
  final String descricao;

  const Caracteristica({required this.id, required this.descricao});

  factory Caracteristica.fromJson(Map<String, dynamic> json) {
    return Caracteristica(
      id: json['id'],
      descricao: json['descricao'],
    );
  }
}
