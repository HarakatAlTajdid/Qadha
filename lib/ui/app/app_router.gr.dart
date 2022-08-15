// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;

import '../../main.dart' as _i4;
import '../views/calendars/calendars_view.dart' as _i6;
import '../views/main/main_view.dart' as _i5;
import '../views/rewards/rewards_view.dart' as _i7;
import '../views/settings/settings_view.dart' as _i9;
import '../views/stats/stats_view.dart' as _i8;
import '../views/welcome/login/login_view.dart' as _i3;
import '../views/welcome/verification/verification_view.dart' as _i2;
import '../views/welcome/welcome_view.dart' as _i1;

class AppRouter extends _i10.RootStackRouter {
  AppRouter([_i11.GlobalKey<_i11.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    WelcomeRoute.name: (routeData) {
      final args = routeData.argsAs<WelcomeRouteArgs>(
          orElse: () => const WelcomeRouteArgs());
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData,
          child:
              _i1.WelcomeView(checkSession: args.checkSession, key: args.key));
    },
    VerificationRoute.name: (routeData) {
      final args = routeData.argsAs<VerificationRouteArgs>();
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i2.VerificationView(args.phoneCode, args.phoneNumber,
              args.password, args.verificationId,
              key: args.key));
    },
    LoginRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.LoginView());
    },
    HomeRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.HomeView());
    },
    MainRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.MainView());
    },
    CalendarsRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.CalendarsView());
    },
    RewardsRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.RewardsView());
    },
    StatsRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.StatsView());
    },
    SettingsRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.SettingsView());
    }
  };

  @override
  List<_i10.RouteConfig> get routes => [
        _i10.RouteConfig(WelcomeRoute.name, path: '/'),
        _i10.RouteConfig(VerificationRoute.name, path: '/verification-view'),
        _i10.RouteConfig(LoginRoute.name, path: '/login-view'),
        _i10.RouteConfig(HomeRoute.name, path: '/home-view', children: [
          _i10.RouteConfig(MainRoute.name,
              path: 'main-view', parent: HomeRoute.name),
          _i10.RouteConfig(CalendarsRoute.name,
              path: 'calendars-view', parent: HomeRoute.name),
          _i10.RouteConfig(RewardsRoute.name,
              path: 'rewards-view', parent: HomeRoute.name),
          _i10.RouteConfig(StatsRoute.name,
              path: 'stats-view', parent: HomeRoute.name),
          _i10.RouteConfig(SettingsRoute.name,
              path: 'settings-view', parent: HomeRoute.name)
        ])
      ];
}

/// generated route for
/// [_i1.WelcomeView]
class WelcomeRoute extends _i10.PageRouteInfo<WelcomeRouteArgs> {
  WelcomeRoute({bool checkSession = true, _i11.Key? key})
      : super(WelcomeRoute.name,
            path: '/',
            args: WelcomeRouteArgs(checkSession: checkSession, key: key));

  static const String name = 'WelcomeRoute';
}

class WelcomeRouteArgs {
  const WelcomeRouteArgs({this.checkSession = true, this.key});

  final bool checkSession;

  final _i11.Key? key;

  @override
  String toString() {
    return 'WelcomeRouteArgs{checkSession: $checkSession, key: $key}';
  }
}

/// generated route for
/// [_i2.VerificationView]
class VerificationRoute extends _i10.PageRouteInfo<VerificationRouteArgs> {
  VerificationRoute(
      {required String phoneCode,
      required String phoneNumber,
      required String password,
      required String verificationId,
      _i11.Key? key})
      : super(VerificationRoute.name,
            path: '/verification-view',
            args: VerificationRouteArgs(
                phoneCode: phoneCode,
                phoneNumber: phoneNumber,
                password: password,
                verificationId: verificationId,
                key: key));

  static const String name = 'VerificationRoute';
}

class VerificationRouteArgs {
  const VerificationRouteArgs(
      {required this.phoneCode,
      required this.phoneNumber,
      required this.password,
      required this.verificationId,
      this.key});

  final String phoneCode;

  final String phoneNumber;

  final String password;

  final String verificationId;

  final _i11.Key? key;

  @override
  String toString() {
    return 'VerificationRouteArgs{phoneCode: $phoneCode, phoneNumber: $phoneNumber, password: $password, verificationId: $verificationId, key: $key}';
  }
}

/// generated route for
/// [_i3.LoginView]
class LoginRoute extends _i10.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: '/login-view');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i4.HomeView]
class HomeRoute extends _i10.PageRouteInfo<void> {
  const HomeRoute({List<_i10.PageRouteInfo>? children})
      : super(HomeRoute.name, path: '/home-view', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i5.MainView]
class MainRoute extends _i10.PageRouteInfo<void> {
  const MainRoute() : super(MainRoute.name, path: 'main-view');

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i6.CalendarsView]
class CalendarsRoute extends _i10.PageRouteInfo<void> {
  const CalendarsRoute() : super(CalendarsRoute.name, path: 'calendars-view');

  static const String name = 'CalendarsRoute';
}

/// generated route for
/// [_i7.RewardsView]
class RewardsRoute extends _i10.PageRouteInfo<void> {
  const RewardsRoute() : super(RewardsRoute.name, path: 'rewards-view');

  static const String name = 'RewardsRoute';
}

/// generated route for
/// [_i8.StatsView]
class StatsRoute extends _i10.PageRouteInfo<void> {
  const StatsRoute() : super(StatsRoute.name, path: 'stats-view');

  static const String name = 'StatsRoute';
}

/// generated route for
/// [_i9.SettingsView]
class SettingsRoute extends _i10.PageRouteInfo<void> {
  const SettingsRoute() : super(SettingsRoute.name, path: 'settings-view');

  static const String name = 'SettingsRoute';
}
