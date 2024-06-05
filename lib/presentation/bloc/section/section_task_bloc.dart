import 'dart:developer';

import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban/presentation/models/section_model.dart';
import 'package:kanban/presentation/models/task_model.dart';
import 'package:kanban/presentation/repositories/get_sections.dart';
import 'package:kanban/presentation/repositories/task.dart';
import 'package:kanban/presentation/screens/home/entity/text_item.dart';

part 'section_state.dart';

class SectionTaskBloc extends Bloc<SectionEvent, SectionState> {
  final SectionRepository sectionRepository;
  final TaskRepository taskRepository;
  final AppFlowyBoardScrollController boardController =
      AppFlowyBoardScrollController();
  late AppFlowyGroupData group1;
  late AppFlowyGroupData group2;
  late AppFlowyGroupData group3;

  late final AppFlowyBoardController controller;
  late Map<String, List<TaskModel>> tasksMap;
  List<AppFlowyGroupData> allGroupData = [];
  SectionTaskBloc(this.sectionRepository, this.taskRepository)
      : super(SectionInitialState()) {
    controller = AppFlowyBoardController(
      onMoveGroupItemToGroup:
          (fromGroupId, fromIndex, toGroupId, toIndex) async {
        TaskModel task = tasksMap[fromGroupId]![fromIndex];
        Map body = {
          "content": task.content,
          "description": task.description,
          if (task.due != null) "due_string": task.due!.string,
          "priority": task.priority,
          "section_id": toGroupId,
          "due_lang": "en",
        };
        await taskRepository.deleteTask(task.id);
        await taskRepository.addTask(body);
        debugPrint('Move $fromGroupId:$fromIndex to $toGroupId:$toIndex');
      },
    );
    on<FetchAllSectionsEvent>((event, emit) async {
      tasksMap = {};
      allGroupData.clear();
      controller.clear();
      emit(SectionLoadingState());
      try {
        final sections = await sectionRepository.call();
        for (Section section in sections) {
          if (section.id.isNotEmpty) {
            tasksMap[section.id] =
                await taskRepository.fetchAllTask(section.id);

            allGroupData.add(
              AppFlowyGroupData(
                id: section.id,
                name: section.name,
                items: tasksMap[section.id]!.map(
                  (e) {
                    String title =
                        "${e.content}!@#${e.id}!@#${e.commentCount}!@#${e.priority}";
                    if (e.description.isEmpty) {
                      return TextItem(title);
                    } else {
                      return RichTextItem(
                          title: title, subtitle: e.description);
                    }
                  },
                ).toList(),
              ),
            );
            controller.addGroup(allGroupData[sections.indexOf(section)]);
            // debugger();
          }
        }
        emit(ConcreteSectionsSuccessState(sections, tasksMap));
      } catch (error, stacktrace) {
        log(stacktrace.toString());
        emit(SectionErrorState(error.toString()));
      }
    });
  }
}
