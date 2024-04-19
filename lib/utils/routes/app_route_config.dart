import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:thoughts/features/auth/screens/login_screen.dart';
import 'package:thoughts/features/auth/screens/onboarding_screen.dart';
import 'package:thoughts/features/auth/screens/signup_screen.dart';
import 'package:thoughts/features/home/screens/notes_screen.dart';
import 'package:thoughts/features/home/screens/home_screen.dart';
import 'package:thoughts/utils/routes/app_route_constant.dart';

class AppRouteConfig {
  final GoRouter router =
      GoRouter(initialLocation: AppRouteConstant.loginScreen, routes: [
    GoRoute(
        path: '/loginScreen',
        name: AppRouteConstant.loginScreen,
        builder: (context, state) {
          final SupabaseClient supabase = Supabase.instance.client;
          if (supabase.auth.currentSession?.isExpired ?? true) {
            return const LoginScreen();
          } else {
            return const HomeScreen();
          }
        }),
    GoRoute(
      path: '/onboardingScreen',
      name: AppRouteConstant.onboardingScreen,
      builder: (context, state) => const OnBoardingScreen(),
    ),
    GoRoute(
      path: '/signupScreen',
      name: AppRouteConstant.signupScreen,
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/homeScreen',
      name: AppRouteConstant.homeScreen,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
        path: '/noteScreen',
        name: AppRouteConstant.noteScreen,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return NoteScreen(
            updateNote: extra['updateNote'],
            noteId: extra['noteId'],
            title: extra['title'],
            body: extra['body'],
          );
        })
  ]);
}
