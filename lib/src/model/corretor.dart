import 'package:sisgerim/src/model/pessoa.dart';

class Corretor extends Pessoa {
  final String creci;
  final String imobiliaria;
  final String senha;
  final List<String> redesSociais;
  const Corretor({
    required this.creci,
    required this.imobiliaria,
    required this.senha,
    required this.redesSociais,
    required super.id,
    // required super.endereco,
    required super.nome,
    required super.email,
    required super.telefone,
    // required super.cpf,
    // required super.excluidoEm,
  });

  factory Corretor.fromJson(Map<String, dynamic> json) {
    return Corretor(
      id: json['id'],
      // endereco: json['idEndereco'],
      nome: json['nome'],
      email: json['email'],
      telefone: json['telefone'],
      // cpf: json['cpf'],
      // excluidoEm: json['excluidoEm'],
      creci: json['creci'],
      imobiliaria: json['imobiliaria'],
      senha: json['senha'],
      redesSociais: json['redesSociais'],
    );
  }
}
