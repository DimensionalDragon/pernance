import 'package:realm/realm.dart';

import 'package:pernance/models/user.dart';
import 'package:pernance/models/subtransaction.dart';
import 'package:pernance/models/transaction.dart';
import 'package:pernance/models/category.dart';

var config = Configuration.local([
  AppUser.schema,
  FinancialTransaction.schema,
  FinancialSubtransaction.schema,
  Category.schema,
]);
var realm = Realm(config);

// Future<User> loginCustomJwt(App app, String jwt) async {
//   // Create a Custom JWT credential
//   final credentials = Credentials.jwt(jwt);
//   // Authenticate the user
//   final user = await app.logIn(credentials);
//   // `app.currentUser` updates to match the logged in user
//   assert(user.id == app.currentUser?.id);
//   return user;
// }

// void main() async {
//   final app = App(AppConfiguration('your-app-id'));
//   final user = await loginCustomJwt(app, 'eyJ0eXAi...Q3NJmnU8oP3YkZ8');
//   print('Logged in user: ${user.id}');
// }
