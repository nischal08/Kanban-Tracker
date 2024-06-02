import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kanban/core/values/constants/app_routes.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Error Screen"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go(AppRoutes.homeRoute),
          child: const Text("Go to home page"),
        ),
      ),
    );
  }
}
