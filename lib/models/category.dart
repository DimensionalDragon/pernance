import 'package:realm/realm.dart';

part 'category.realm.dart';

@RealmModel()
class _Category {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  
  late _User? user;
  late String name;
  late int budget;
  late List<_Transaction> transactions;
}