
import 'builders/IdentityBuilder.dart';

abstract class Identifier {
  
  void upgrade(IdentityBuilder identityBuilder);

  void downgrade(IdentityBuilder identityBuilder);

}