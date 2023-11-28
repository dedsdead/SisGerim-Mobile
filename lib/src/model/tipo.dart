class Tipo {
  final String id;
  final String nome;

  const Tipo({required this.id, required this.nome});

  factory Tipo.fromJson(Map<String, dynamic> json) {
    return Tipo(
      id: json['id'],
      nome: json['nome'],
    );
  }
}
