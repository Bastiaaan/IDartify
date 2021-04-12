import 'dart:io';
import 'Logging.dart';

class Logger implements Logging {

  @override
  Future log(String content, FileSystemEntity resource) async {
    var targetFile = await _transactionsFileCreatOrOpen();

  }

  @override
  Future<void> logError(String message, Error err) async {
    var targetFile = await _errorsFileCreatOrOpen();
    await targetFile.setLastModified(DateTime.now());
    
  }

  Future<File> _transactionsFileCreatOrOpen() async {
    var file = File('IDartify\\logs\\transactions.txt');
    await file.exists() 
    ? file.openWrite()
    : file.create(recursive: true);

    return file;
  }

  Future<File> _errorsFileCreatOrOpen() async {
    var file = File('IDartify\\logs\\errors.txt');
    await file.exists() 
    ? file.openWrite()
    : file.create(recursive: true);

    return file;
  }

}