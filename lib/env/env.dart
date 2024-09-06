import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
    @EnviedField(varName: 'FIREBASE_WEB_API_KEY')
    static const String firebaseWebAPIKey = _Env.firebaseWebAPIKey;
    @EnviedField(varName: 'FIREBASE_ANDROID_API_KEY')
    static const String firebaseAndroidAPIKey = _Env.firebaseAndroidAPIKey;
    @EnviedField(varName: 'FIREBASE_AUTH_DOMAIN')
    static const String firebaseAuthDomain = _Env.firebaseAuthDomain;
    @EnviedField(varName: 'FIREBASE_PROJECT_ID')
    static const String firebaseProjectID = _Env.firebaseProjectID;
    @EnviedField(varName: 'FIREBASE_STORAGE_BUCKET')
    static const String firebaseStorageBucket = _Env.firebaseStorageBucket;
    @EnviedField(varName: 'FIREBASE_MESSAGING_SENDER_ID')
    static const String firebaseMessagingSenderID = _Env.firebaseMessagingSenderID;
    @EnviedField(varName: 'FIREBASE_WEB_APP_ID')
    static const String firebaseWebAppID = _Env.firebaseWebAppID;
    @EnviedField(varName: 'FIREBASE_ANDROID_APP_ID')
    static const String firebaseAndroidAppID = _Env.firebaseAndroidAppID;

    @EnviedField(varName: 'REALM_APP_ID')
    static const String realmAppID = _Env.realmAppID;
}