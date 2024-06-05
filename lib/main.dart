import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:kanban/core/dio/dio_dependency_injection.dart';
import 'package:kanban/core/styles/themes.dart';
import 'package:kanban/core/values/routes_config.dart';
import 'package:kanban/presentation/bloc/section/section_task_bloc.dart';
import 'package:kanban/presentation/bloc/task/add_task_bloc.dart';
import 'package:kanban/presentation/bloc/task/move_task_cubit.dart';
import 'package:kanban/presentation/repositories/get_sections.dart';
import 'package:kanban/presentation/repositories/task.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  setupApiManager();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<SectionTaskBloc>(
              create: (context) => SectionTaskBloc(
                  GetAllSectionsRepository(), TasksRepositoryImpl()),
            ),
            BlocProvider<AddTaskBloc>(
              create: (context) => AddTaskBloc(TasksRepositoryImpl()),
            ),
            BlocProvider<MoveTaskCubit>(
              create: (context) => MoveTaskCubit(TasksRepositoryImpl()),
            ),
          ],
          child: MaterialApp.router(
            routerConfig: routerConfig,
            builder: (context, child) {
              return Overlay(
                initialEntries: [
                  if (child != null) ...[
                    OverlayEntry(
                      builder: (context) => child,
                    )
                  ]
                ],
              );
            },
            debugShowCheckedModeBanner: false,
            title: 'Kanban',
            theme: theme,
          ),
        );
      },
    );
  }
}
