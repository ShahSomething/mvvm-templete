import 'package:flutter/material.dart';

class NetworkErrorDialog extends StatelessWidget {
  const NetworkErrorDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Text('network_error_title'),
      content: Text('network_error_content'),
    );
  }
}
