import 'package:auto_route/auto_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:qadha/ui/app/app_router.gr.dart';
import 'package:qadha/ui/app/app_theme.dart';
import 'package:qadha/ui/app/locator.dart';
import 'package:qadha/ui/common/navbar/qadha_navbar.dart';
import 'package:qadha/ui/common/navbar/qadha_navbar_item.dart';

import 'firebase_options.dart';

Future<void> main() async {
  setupLocator();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<QadhaNavbarItem> navbarItems = [
    QadhaNavbarItem(0, "Accueil", "assets/images/icons/home.svg"),
    QadhaNavbarItem(1, "Calendriers", "assets/images/icons/calendar.svg"),
    QadhaNavbarItem(2, "Trophées", "assets/images/icons/trophy.svg"),
    QadhaNavbarItem(3, "Statistiques", "assets/images/icons/stats.svg"),
    QadhaNavbarItem(4, "Paramètres", "assets/images/icons/cog.svg")
  ];

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      lazyLoad: false,
      animationDuration: const Duration(seconds: 0),
        resizeToAvoidBottomInset: false,
        routes: const [
          MainRoute(),
          CalendarsRoute(),
          RewardsRoute(),
          StatsRoute(),
          SettingsRoute()
        ],
        appBarBuilder: (_, tabsRouter) => AppBar(
              backgroundColor: AppTheme.primaryColor,
              centerTitle: true,
              toolbarHeight: 70,
              title: Text(navbarItems[tabsRouter.activeIndex].label,
                  style: const TextStyle(
                      color: Colors.black, fontSize: 18, fontFamily: "Inter Regular")),
              actions: [
                SizedBox(
                  width: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(Icons.notifications, color: Colors.grey, size: 26),
                  CircleAvatar(
                    backgroundColor: AppTheme.deadColor,
                    radius: 10,
                  ),
                  const SizedBox(width: 7.5)
                    ],
                  ),
                ),
              ],
            ),
        bottomNavigationBuilder: (_, tabsRouter) {
          return QadhaNavbar(
              initialIndex: tabsRouter.activeIndex,
              onSelectionChanged: (index) {
                tabsRouter.setActiveIndex(index);
              },
              items: navbarItems);
        });
  }
}
