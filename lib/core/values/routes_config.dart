import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kanban/core/values/constants/app_routes.dart';
import 'package:kanban/presentation/screens/error_screen.dart';
import 'package:kanban/presentation/screens/home/home_screen.dart';
import 'package:kanban/presentation/screens/splash_screen.dart';

GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
final GoRouter routerConfig = GoRouter(
  initialLocation: AppRoutes.splashRoute,
  navigatorKey: navKey,
  routes: [
    GoRoute(
      name: "Splash Screen",
      path: AppRoutes.splashRoute,
      builder: (context, state) => const SplashScreen(),
      redirect: (context, state) {
        //Above context is not usable for navigating
        Future.delayed(const Duration(seconds: 2)).then(
          (value) {
            navKey.currentState!.context.go(AppRoutes.homeRoute);
          },
        );
        return null;
        // if (userIsNotLoggedIn){
        //   return "/login";
        // }
        // return "/";
      },
    ),
    GoRoute(
      name: "Home Screen",
      path: AppRoutes.homeRoute,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
  errorBuilder: (context, state) => const ErrorScreen(),
);
