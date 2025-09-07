import 'package:connectinno_case/core/di/locator.dart';
import 'package:connectinno_case/core/routing/routing.dart';
import 'package:connectinno_case/core/services/note_services.dart';
import 'package:connectinno_case/ui/pages/main_page/pages/home_page/viewmodel/home_cubit.dart';
import 'package:connectinno_case/ui/pages/login_page/viewmodel/login_cubit.dart';
import 'package:connectinno_case/ui/pages/note_details_page/viewmodel/note_details_cubit.dart';
import 'package:connectinno_case/ui/pages/register_page/viewmodel/register_cubit.dart';
import 'package:connectinno_case/ui/pages/note_details_page/viewmodel/note_details_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  setupLocator();
  await Supabase.initialize(
    url: 'https://zkbcpckyvwljzsmvceuy.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InprYmNwY2t5dndsanpzbXZjZXV5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTcxMDA5ODQsImV4cCI6MjA3MjY3Njk4NH0.TDGWT-InT3KeHN7flBYBXCyiFVU8udL8ZzOfbC-cmIs',
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<RegisterCubit>(create: (_) => RegisterCubit()),
        BlocProvider<LoginCubit>(create: (_) => LoginCubit()),
        BlocProvider<HomeCubit>(create: (_) => GetIt.I<HomeCubit>()),
        BlocProvider<NoteDetailsCubit>(create: (_) => GetIt.I<NoteDetailsCubit>()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static final AppRouter appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(debugShowCheckedModeBanner: false, title: 'Connectinno', routerConfig: appRouter.config());
  }
}
