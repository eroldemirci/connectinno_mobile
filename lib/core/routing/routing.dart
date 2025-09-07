import 'package:auto_route/auto_route.dart';
import 'package:connectinno_case/core/routing/routing.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  AppRouter();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: RegisterRoute.page),
    AutoRoute(page: NoteDetailsRoute.page),
    AutoRoute(
      page: MainRoute.page,
      children: <AutoRoute>[AutoRoute(page: HomeRoute.page), AutoRoute(page: SettingsRoute.page)],
    ),
  ];
}
