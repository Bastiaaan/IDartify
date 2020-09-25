import 'dart:io';
import 'package:args/args.dart';

class CliCommands {
  static void main(List<String> args) {
    final exitcode = 0;
    final commandLine = 'SQLQueryGenerator run';
    // calling commandLine needs to occure the main.dart in the root-folder
    // 

    final parser = ArgParser();
    parser.addOption(commandLine);
  }
}