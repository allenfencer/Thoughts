// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:thoughts/features/auth/services/auth_service.dart';

import '../../../utils/routes/app_route_constant.dart';

final passwordVisibilityProvider = StateProvider<bool>((ref) => true);

final authProvider =
    StateNotifierProvider<AuthProvider, bool>((ref) => AuthProvider());

class AuthProvider extends StateNotifier<bool> {
  AuthProvider() : super(false);

  login(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      state = true;
      await AuthService().signInWithEmail(
        email,
        password,
      );
      context.goNamed(AppRouteConstant.homeScreen);
      state = false;
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    } finally {
      state = false;
    }
  }

  signup(
      {required BuildContext context,
      required String name,
      required String email,
      required String password}) async {
    try {
      state = true;
      await AuthService().signUpNewUser(email, password, name);
      context.goNamed(AppRouteConstant.homeScreen);
      state = false;
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    } finally {
      state = false;
    }
  }

  logout({required BuildContext context}) async {
    try {
      state = true;
      await AuthService().signOut();
      context.pop();
      context.goNamed(AppRouteConstant.loginScreen);
      state = false;
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    } finally {
      state = false;
    }
  }
}
