class Endereco {
  final String id;
  final String cep;
  final String uf;
  final String localidade;
  final String bairro;
  final String logradouro;
  final int numero;
  final String complemento;

  const Endereco(
      {required this.complemento,
      required this.logradouro,
      required this.numero,
      required this.id,
      required this.cep,
      required this.uf,
      required this.localidade,
      required this.bairro});

  factory Endereco.fromJson(Map<String, dynamic> json) {
    return Endereco(
      id: json['id'],
      cep: json['cep'],
      uf: json['uf'],
      localidade: json['localidade'],
      bairro: json['bairro'],
      logradouro: json['logradouro'],
      numero: json['numero'],
      complemento: json['complemento'] ?? '',
    );
  }
}
