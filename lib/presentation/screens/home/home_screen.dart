import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kanban/presentation/bloc/section/section_task_bloc.dart';
import 'package:kanban/presentation/screens/home/widgets/all_board.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late final SectionTaskBloc sectionBloc;
  @override
  void initState() {
    super.initState();
    sectionBloc = BlocProvider.of<SectionTaskBloc>(context);
    sectionBloc.add(FetchAllSectionsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text("Kanban dashboard"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: BlocBuilder<SectionTaskBloc, SectionState>(
          builder: (_, state) {
            return switch (state) {
              SectionInitialState _ =>
                const Center(child: Text('Fetching sections...')),
              SectionLoadingState _ =>
                const Center(child: CircularProgressIndicator()),
              SectionErrorState _ => Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.h),
                    child: Text('Error: ${state.error}'),
                  ),
                ),
              SectionSuccessState _ => const AllBoard(),
            };
          },
        ),
      ),
    );
  }
}
