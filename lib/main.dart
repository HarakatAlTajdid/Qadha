import 'package:auto_route/auto_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:qadha/ui/app/app_router.gr.dart';
import 'package:qadha/ui/app/app_theme.dart';
import 'package:qadha/ui/common/navbar/qadha_navbar.dart';
import 'package:qadha/ui/common/navbar/qadha_navbar_item.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  initializeDateFormatting("fr_fr");

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  MyApp({Key? key}) : super(key: key);

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        routes: [
          const MainRoute(),
          CalendarsRoute(),
          const AchievementsRoute(),
          const StatsRoute(),
          const SettingsRoute()
        ],
        appBarBuilder: (_, tabsRouter) => AppBar(
              backgroundColor: AppTheme.primaryColor,
              centerTitle: true,
              toolbarHeight: 70,
              shadowColor: Colors.transparent,
              title: Text(navbarItems[tabsRouter.activeIndex].label,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: "Inter Regular")),
              bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(1.0),
                  child: Container(
                    color: AppTheme.deadColor,
                    height: 0.65,
                  )),
              leadingWidth: 44,
              leading: Padding(
                  padding: const EdgeInsets.only(left: 17.5),
                  child: Image.asset(
                    "assets/images/qadha_blue.png",
                    fit: BoxFit.fitWidth,
                    colorBlendMode: BlendMode.srcIn,
                    color: Colors.grey
                  )),
              actions: [
                SizedBox(
                  width: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SvgPicture.asset("assets/images/icons/bell.svg"),
                      const SizedBox(width: 2.5),
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
            key: UniqueKey(),
              initialIndex: tabsRouter.activeIndex,
              onSelectionChanged: (index) {
                tabsRouter.setActiveIndex(index);
              },
              items: navbarItems);
        });
  }
}
