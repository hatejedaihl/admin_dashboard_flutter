import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/api/backend_api.dart';

import 'package:admin_dashboard/router/router.dart';

import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/providers/sidemenu_provider.dart';
import 'package:admin_dashboard/providers/categories_provider.dart';

import 'package:admin_dashboard/services/local_Storage.dart';
import 'package:admin_dashboard/services/notifications_services.dart';
import 'package:admin_dashboard/services/navigation_service.dart';

import 'package:admin_dashboard/ui/layouts/auth/auth_layout.dart';
import 'package:admin_dashboard/ui/layouts/splash/splash_layout.dart';
import 'package:admin_dashboard/ui/layouts/dashboard/dashboard_layout.dart';

void main() async {
  
  await LocalStorage.configurePrefs();
  BackendApi.configureDio();

  Flurorouter.configureRoutes();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false, create: (_) => AuthProvider()),
        ChangeNotifierProvider(lazy: false, create: (_) => SideMenuProvider(),),
        ChangeNotifierProvider(lazy: false, create: (_) => CategoriesProvider(),),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Dashboard',
      // home: Container(),
      initialRoute: '/',
      onGenerateRoute: Flurorouter.router.generator,
      navigatorKey: NavigationService.navigatorKey,
      scaffoldMessengerKey: NotificationsService.messengerKey,
      builder: (_, child) {
        final authProvider = Provider.of<AuthProvider>(context);
        if(authProvider.authStatus == AuthStatus.checking) return const SplashLayout();
        if(authProvider.authStatus == AuthStatus.authenticated) {
          return DashboarLayout(child: child!);
        } else {
          return AuthLayout(child: child!);
        }
      },
      theme: ThemeData.light().copyWith(
        scrollbarTheme: const ScrollbarThemeData().copyWith(
          thumbColor: MaterialStateProperty.all(
          Colors.grey.withOpacity(0.5),
          )
        )
      ),
    );
  }
}