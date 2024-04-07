import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabaseProvider = Provider((ref) => Supabase.instance.client);

class AuthService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> signUpNewUser(String email, String password, String name) async {
    final AuthResponse res = await supabase.auth.signUp(
        email: email.trim(), password: password.trim(), data: {'name': name});
    await supabase.from('User').insert({'email': email, 'name': name});
  }

  Future<void> signInWithEmail(String email, String password) async {
    final AuthResponse res = await supabase.auth.signInWithPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }
}
