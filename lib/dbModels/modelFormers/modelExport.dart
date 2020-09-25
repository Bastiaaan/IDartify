
//*
//* Since there is no method to import all model-objects automatically via reflection (yet).
//* In order to import all the models, the exisiting models are manually writen below.
//*
import 'dart:io';

Future manageSeeding() async {
  
  final targetDir = Directory.fromUri(Uri.parse('lib/dbModels'));
  var toList = targetDir.listSync(recursive: false).where((element) => element.path.contains('.dart'));

  var fileContent = '''import 'package:cli/src/SeedManager.dart';\n'''; 

  for(var i = 0; i < toList.length; i++) {    
    var databaseModel = _getDatabaseModelName(toList.elementAt(i));     
    fileContent += '''import 'package:cli/dbModels/${databaseModel}.dart'; \n''';
    if(i == toList.length - 1) {
      fileContent += '''\nFuture seedTables() async {
    var seedManagers = List<SeedManager>();\n''';
      for(var j = 0; j <= i; j++) {
        databaseModel = _getDatabaseModelName(toList.elementAt(j)); 
        fileContent += '    seedManagers.add(SeedManager<${databaseModel}>());\n';
      }
      fileContent += '''    seedManagers.forEach((seedManager) async => {
        await seedManager.initializeTable()
    });\n''';
      fileContent += '}';
    }
  } 

  final targetPath = Directory.current.path+'\\lib\\src\\generatedCode\\growSeed.dart';

  !await File(targetPath).exists() ? 
    File(targetPath).create(recursive: true).then((value) => {      
      value.openWrite().write(fileContent),
      print("file: 'growSeed.dart' has been created")
    }) : print("file: 'growSeed.dart' already exists");
}

String _getDatabaseModelName(FileSystemEntity file) {
  var pathParts = file.path.split('\\');
  var fileName = pathParts.elementAt(pathParts.length - 1);
  return fileName.split('.').elementAt(0);
}