import 'package:sisgerim/src/model/endereco.dart';

class Pessoa {
  final String id;
  // final Endereco? endereco;
  final String nome;
  final String email;
  final String telefone;
  // final String? cpf;
  // final String? excluidoEm;

  const Pessoa(
      // this.endereco, this.cpf, this.excluidoEm,
      {required this.id,
      required this.nome,
      required this.email,
      required this.telefone});
  // }
}
