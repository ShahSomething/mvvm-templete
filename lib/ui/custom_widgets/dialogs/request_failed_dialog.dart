import 'package:flutter/material.dart';

class RequestFailedDialog extends StatelessWidget {
  final String errorMessage;

  const RequestFailedDialog({Key? key, required this.errorMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('requestFailedTitle'),
      content: Text(errorMessage),
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
