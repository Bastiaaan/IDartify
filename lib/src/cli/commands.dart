import 'dart:io';
import 'package:args/args.dart';

class CliCommands {

  String _appName = 'SQG';
  String _upgradeIdentity = 'upgrade identity';
  String _downgradeIdentity = 'downgrade identity';
  String _applySchema = 'apply schema';

  static void main(List<String> args) {
    final exitcode = 0;
    final commandLine = 'run';
    // calling commandLine needs to occure the main.dart in the root-folder

    final parser = ArgParser();
    parser.addOption(commandLine);
  }

  void _upgrade(String identityName) {
    _upgradeIdentity += ' ${identityName}';

    // TODO: add a file with a class which generates a ${schemaName}Identifier class who implements the  the 
  }

  void _downgrade() {
    // TODO: Remove latest migration on the Database Identifier
  }
}