import 'dart:io';
import 'Logging.dart';

class Logger implements LoggingInterface {

  @override
  Future log(String content, FileSystemEntity resource) async {
    var targetFile = await _transactionsFileCreatOrOpen();

  }

  @override
  Future logError(String message, Error err) async {
    var targetFile = await _errorsFileCreatOrOpen();
  }

  Future<File> _transactionsFileCreatOrOpen() async {
    var file = File('SQLQueryGenerator\\logs\\transactions.txt');
    await file.exists() 
    ? file.openWrite()
    : file.create(recursive: true);

    return file;
  }

  Future<File> _errorsFileCreatOrOpen() async {
    var file = File('SQLQueryGenerator\\logs\\errors.txt');
    await file.exists() 
    ? file.openWrite()
    : file.create(recursive: true);

    return file;
  }

}