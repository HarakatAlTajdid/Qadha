import 'package:auto_route/auto_route.dart';
import 'package:qadha/main.dart';
import 'package:qadha/ui/views/calendars/calendars_view.dart';
import 'package:qadha/ui/views/main/main_view.dart';
import 'package:qadha/ui/views/rewards/rewards_view.dart';
import 'package:qadha/ui/views/settings/settings_view.dart';
import 'package:qadha/ui/views/stats/stats_view.dart';
import 'package:qadha/ui/views/welcome/login/login_view.dart';
import 'package:qadha/ui/views/welcome/verification/verification_view.dart';
import 'package:qadha/ui/views/welcome/welcome_view.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'View,Route',
  routes: <AutoRoute>[
    AutoRoute(page: WelcomeView, initial: true),
    AutoRoute(page: VerificationView),
    AutoRoute(page: LoginView),
    AutoRoute(page: HomeView, children: [
      AutoRoute(page: MainView),
      AutoRoute(page: CalendarsView),
      AutoRoute(page: RewardsView),
      AutoRoute(page: StatsView),
      AutoRoute(page: SettingsView),
    ])
  ],
)
class $AppRouter {}
