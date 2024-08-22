import 'package:realm/realm.dart';

import 'user.dart';

part 'category.realm.dart';

@RealmModel()
class $Category {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  
  late $User? user;
  late String name;
  late int budget;
  // late List<_Transaction> transactions;
}