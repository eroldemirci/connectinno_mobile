import 'package:auto_route/auto_route.dart';
import 'package:connectinno_case/core/managers/auth_manager/auth_manager.dart';
import 'package:connectinno_case/core/routing/routing.gr.dart';
import 'package:connectinno_case/ui/shared/base_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void initState() {
    super.initState();
    Future.microtask(() async {
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;
      final user = await AuthManager().loadUserFromCache();
      if (user == null) {
        context.router.replace(const LoginRoute());
      } else {
        context.router.replace(const MainRoute());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.sticky_note_2_rounded, size: 72, color: Colors.amber[800]),
            const SizedBox(height: 24),
            Text('Connectinno Notes', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87, letterSpacing: 1.2)),
          ],
        ),
      ),
    );
  }
}
