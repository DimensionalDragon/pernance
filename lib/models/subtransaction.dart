import 'package:realm/realm.dart';

import 'transaction.dart';

part 'subtransaction.realm.dart';

@RealmModel()
class $Subtransaction {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  
  late $Transaction? transaction;
  late String name;
  late int price;
}