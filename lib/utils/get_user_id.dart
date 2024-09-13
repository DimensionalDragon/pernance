import 'package:supabase_flutter/supabase_flutter.dart';

Future<String?> getUserId() async {
  final session = Supabase.instance.client.auth.currentSession;
  if (session != null) {
    return session.user.id;
  } else {
    return null;
  }
}