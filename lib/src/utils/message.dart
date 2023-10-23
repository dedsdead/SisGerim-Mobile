import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class MessageApp {
  static const errorPasswordMismatch = 'Senha e Confirmação não conferem';
  static const errorWrongLoginPassword = 'Login ou Senha incorretos';

  static toastMesssage(
    BuildContext context,
    String message, {
    Color color = Colors.red,
    IconData icon = Icons.error,
    void Function()? f,
  }) {
    FToast fToast = FToast();
    fToast.init(context);
    fToast.showToast(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              onPressed: f,
              icon: Icon(icon),
              color: Colors.white,
            ),
            Text(
              message,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
          ],
        ),
      ),
      toastDuration: const Duration(
        seconds: 3,
      ),
    );
  }
}
