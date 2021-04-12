
import 'dart:io';

abstract class Logging {

  void log(String content, FileSystemEntity resource);

  void logError(String message, Error err);
}