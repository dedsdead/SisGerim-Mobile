import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FormTextField extends StatelessWidget {
  final String hintName;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType inputType;
  final bool isObscured;
  final bool isEnabled;

  const FormTextField(
      {super.key,
      required this.hintName,
      required this.icon,
      required this.controller,
      required this.inputType,
      this.isObscured = false,
      this.isEnabled = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 30,
        right: 30,
        left: 30,
      ),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Por favor insira o campo $hintName';
          } else if (hintName == 'Nome' &&
              (!validateName(value) || value.length < 3)) {
            return "Insira um nome válido!";
          } else if (hintName == 'Email' &&
              (!validateEmail(value) || value.length < 3)) {
            return "Insira um email válido!";
          }
          return null;
        },
        obscureText: isObscured,
        enabled: isEnabled,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade200,
          hintText: "Digite o(a) $hintName",
          labelText: hintName,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
          ),
          prefix: Icon(icon),
        ),
      ),
    );
  }

  // CRIAR A VALIDAçÂO DE EMAIL
  validateName(String nome) {
    final reg = RegExp(r'(^\s*[A-Za-z]{3}[^\n\d]*$)');
    return reg.hasMatch(nome);
  }

  validateEmail(String email) {
    final reg = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return reg.hasMatch(email);
  }
}
