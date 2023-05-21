import 'package:flutter/material.dart';

class RequestSuccessDialog extends StatelessWidget {
  final String successMsg;

  const RequestSuccessDialog({Key? key, required this.successMsg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('requestSuccessTitle'),
      content: Text(successMsg),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('ok'),
        ),
      ],
    );
  }
}
