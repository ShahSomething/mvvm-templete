import 'package:logger/logger.dart';
import 'package:mvvm_template/core/others/logger_customization/custom_log_output.dart';
import 'package:mvvm_template/core/others/logger_customization/custom_log_printer.dart';

class CustomLogger extends Logger {
  final String className;

  CustomLogger({required this.className})
      : super(
          output: CustomLogOutput(),
          printer: CustomLogPrinter(className: className),
        );
}
