import 'package:sisgerim/src/model/caracteristica.dart';
import 'package:sisgerim/src/model/endereco.dart';
import 'package:sisgerim/src/model/pessoa.dart';
import 'package:sisgerim/src/model/tipo.dart';

class Cliente extends Pessoa {
  final Tipo tipo;
  final List<dynamic> caracteristicas;
  final String bairro;
  const Cliente(
      // super.endereco,
      // super.cpf,
      // super.excluidoEm,
      {
    required this.tipo,
    required this.caracteristicas,
    required this.bairro,
    required super.id,
    required super.nome,
    required super.email,
    required super.telefone,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    var getCaracteristicas = json['caracteristicas']
        .map((data) => Caracteristica.fromJson(data))
        .toList();
    return Cliente(
      id: json['id'],
      // endereco: Endereco.fromJson(json['endereco']),
      nome: json['nome'],
      email: json['email'],
      telefone: json['telefone'],
      // cpf: json['cpf'],
      // excluidoEm: json['excluidoEm'],
      tipo: Tipo.fromJson(json['tipo']),
      caracteristicas: getCaracteristicas,
      bairro: json['bairro'],
    );
  }
}
