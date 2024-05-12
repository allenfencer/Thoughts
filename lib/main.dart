import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:thoughts/utils/constants/keys.dart';
import 'package:thoughts/utils/routes/app_route_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );
  // await AuthService().signOut();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Thoughts',
        routerConfig: AppRouteConfig().router,
        theme: ThemeData(
          fontFamily: 'Dot-Matrix',
          useMaterial3: true,
        ),
      ),
    );
  }
}
