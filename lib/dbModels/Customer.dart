import 'package:cli/propertyAnnotations/dataAnnotations.dart';
import 'package:cli/dbModels/modelFormers/MotherModel.dart';
import 'Vehicle.dart';

@Table('Customer')
class Customer extends MotherModel {

  @DataColumn('name', String)
  String name;

  @DataColumn('vehicle', int, true)
  int vehicle;
}