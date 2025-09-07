import 'package:connectinno_case/ui/shared/base_page.dart';
import 'package:connectinno_case/ui/shared/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:connectinno_case/core/managers/auth_manager/auth_manager.dart';
import 'package:auto_route/auto_route.dart';
import 'package:connectinno_case/core/routing/routing.gr.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: CustomAppBar(titleText: "Settings", centerTitle: true, autoImplementLeading: false,),
      child: ListTile(
        leading: const Icon(Icons.logout, color: Colors.red),
        title: const Text('Çıkış Yap', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
        onTap: () async {
          await AuthManager.instance.logout();
          context.router.popAndPushAll(const [LoginRoute()]);
        },
      ),
    );
  }
}
