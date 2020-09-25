
import 'dart:io';

abstract class LoggingInterface {

  void log(String content, FileSystemEntity resource);

  void logError(String message, Error err);
}