import 'package:realm/realm.dart';

part 'subtransaction.realm.dart';

@RealmModel()
class _Subtransaction {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  
  late _Transaction? transaction;
  late String name;
  late int price;
}