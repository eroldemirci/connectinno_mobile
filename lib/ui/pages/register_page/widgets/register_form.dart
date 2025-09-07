import 'package:connectinno_case/core/routing/routing.gr.dart';
import 'package:connectinno_case/ui/shared/styles/colors.dart';
import 'package:connectinno_case/ui/shared/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import '../viewmodel/register_cubit.dart';
import '../viewmodel/register_state.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterCubit(),
      child: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            context.router.replace(MainRoute());
          } else if (state is RegisterFailure) {
            debugPrint('Registration failed: ${state.errorMessage}');
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage ?? 'Registration failed')));
          }
        },
        child: BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, state) {
            final cubit = context.read<RegisterCubit>();
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  keyboardType: TextInputType.emailAddress,
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
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                  onChanged: cubit.confirmPasswordChanged,
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
                          cubit.registerUser();
                        },
                        child: const Text('Register'),
                      ),
                    ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed:
                      state.isLoading
                          ? null
                          : () {
                            context.replaceRoute(LoginRoute());
                          },
                  child: Text('Already have an account? Login', style: AppTextStyles.p3.copyWith(color: AppColors.primaryBlackColor)),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
