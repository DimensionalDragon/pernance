import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
    @EnviedField(varName: 'FIREBASE_API_KEY')
    static const String firebaseAPIKey = _Env.firebaseAPIKey;
}