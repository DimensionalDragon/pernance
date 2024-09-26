import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
    @EnviedField(varName: 'SUPABASE_PROJECT_URL')
    static const String supabaseProjectURL = _Env.supabaseProjectURL;
    @EnviedField(varName: 'SUPABASE_DB_PASSWORD')
    static const String supabaseDBPassword = _Env.supabaseDBPassword;
    @EnviedField(varName: 'SUPABASE_API_KEY')
    static const String supabaseAPIKey = _Env.supabaseAPIKey;

    @EnviedField(varName: 'POWERSYNC_INSTANCE_URL')
    static const String powersyncInstanceURL = _Env.powersyncInstanceURL;
}