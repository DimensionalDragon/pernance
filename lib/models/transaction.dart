import 'package:realm/realm.dart';

part 'transaction.realm.dart';

@RealmModel()
class _Transaction {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  
  late _User? user;
  late String name;
  late _Category? category;
  late int price;
  late DateTime date;
  late List<_Subtransaction> subtransactions;
}