import 'package:auto_route/auto_route.dart';
import 'package:connectinno_case/ui/shared/base_page.dart';
import 'package:connectinno_case/ui/shared/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'widgets/register_form.dart';

@RoutePage()
class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: CustomAppBar(titleText: 'Register', centerTitle: true, autoImplementLeading: false),
      child: const Center(child: RegisterForm()),
    );
  }
}
