import 'package:cli/propertyAnnotations/dataAnnotations.dart';
import 'package:cli/dbModels/modelFormers/MotherModel.dart';
import 'Order.dart';

@Table('Customer')
class Customer extends MotherModel {

  @DataColumn('name', String)
  String name;

  @DataColumn('vehicle', int)
  int vehicle;

  List<Order> orders;
}