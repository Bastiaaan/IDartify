export 'MotherModel.dart';
import 'package:cli/propertyAnnotations/dataAnnotations.dart';

import 'DatabaseModel.dart';

class MotherModel implements DatabaseModel {

  @override
  @DataColumn('id', int)
  int id;  

  @override
  @DataColumn('addedOn', DateTime)
  DateTime addedOn;  

  @override
  @DataColumn('editedOn', DateTime)
  DateTime editedOn;  

  @override
  @DataColumn('editedBy', int, true)
  int editedBy;
  
  @override
  @DataColumn('createdBy', int)
  int createdBy;
  
}