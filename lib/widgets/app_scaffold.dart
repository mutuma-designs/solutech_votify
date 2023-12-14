import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:solutech_votify/features/settings/presentation/screens/settings_screen.dart';
import '../features/elections/presentation/screens/elections_screen.dart';
import '../features/users/presentation/screens/users_screen.dart';

class AppScaffold extends ConsumerWidget {
  final Widget child;
  const AppScaffold({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, ref) {
    var currentRoute = GoRouter.of(context).location;
    var routes = [
      ElectionsScreen.routePath,
      UsersScreen.routePath,
      SettingsScreen.routePath,
    ];
    var routeIndex = routes.indexOf(currentRoute);

    return Scaffold(
      body: SafeArea(
        child: child,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: routeIndex != -1 ? routeIndex : 0,
        onTap: (index) {
          var route = routes[index];
          context.go(route);
        },
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FeatherIcons.home),
            label: "Elections",
          ),
          BottomNavigationBarItem(
            icon: Icon(FeatherIcons.users),
            label: "Users",
          ),
          BottomNavigationBarItem(
            icon: Icon(FeatherIcons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
