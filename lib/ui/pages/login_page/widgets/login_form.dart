import 'package:auto_route/auto_route.dart';
import 'package:connectinno_case/core/routing/routing.gr.dart';
import 'package:connectinno_case/ui/shared/styles/colors.dart';
import 'package:connectinno_case/ui/shared/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewmodel/login_cubit.dart';
import '../viewmodel/login_state.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            context.router.replace(MainRoute());
          } else if (state is LoginFailure) {
            debugPrint('Login failed: ${state.errorMessage}');
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage ?? 'Login failed')));
          }
        },
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            final cubit = context.read<LoginCubit>();
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  onChanged: cubit.emailChanged,
                  enabled: !state.isLoading,
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  onChanged: cubit.passwordChanged,
                  enabled: !state.isLoading,
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                ),
                const SizedBox(height: 24),
                state.isLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(AppColors.primaryBlackColor),
                          foregroundColor: WidgetStateProperty.all(AppColors.primaryWhiteColor),
                        ),
                        onPressed: () {
                          cubit.loginUser();
                        },
                        child: const Text('Login'),
                      ),
                    ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed:
                      state.isLoading
                          ? null
                          : () {
                            context.replaceRoute(RegisterRoute());
                          },
                  child: Text('Don\'t have an account? Register', style: AppTextStyles.p3.copyWith(color: AppColors.primaryBlackColor)),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
