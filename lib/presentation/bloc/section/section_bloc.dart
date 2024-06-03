import 'dart:developer';

import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban/presentation/models/task_model.dart';
import 'package:kanban/presentation/repositories/get_sections.dart';
import 'package:kanban/presentation/models/section_model.dart';
import 'package:kanban/presentation/repositories/get_tasks.dart';
import 'package:kanban/presentation/screens/home/entity/text_item.dart';
part 'section_state.dart';

class SectionBloc extends Bloc<SectionEvent, SectionState> {
  final SectionRepository sectionRepository;
  final TaskRepository taskRepository;
  final AppFlowyBoardScrollController boardController =
      AppFlowyBoardScrollController();
  late AppFlowyGroupData group1;
  late AppFlowyGroupData group2;
  late AppFlowyGroupData group3;

  final AppFlowyBoardController controller = AppFlowyBoardController(
    onMoveGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      debugPrint('Move item from $fromIndex to $toIndex');
    },
    onMoveGroupItem: (groupId, fromIndex, toIndex) {
      debugPrint('Move $groupId:$fromIndex to $groupId:$toIndex');
    },
    onMoveGroupItemToGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      debugPrint('Move $fromGroupId:$fromIndex to $toGroupId:$toIndex');
    },
  );
  List<AppFlowyGroupData> allGroupData = [];
  SectionBloc(this.sectionRepository, this.taskRepository)
      : super(SectionInitialState()) {
    on<FetchAllSectionsEvent>((event, emit) async {
      emit(SectionLoadingState());
      try {
        final sections = await sectionRepository.call();
        final Map<String, List<TaskModel>> tasksMap = {};
        for (Section section in sections) {
          if (section.id.isNotEmpty) {
            tasksMap[section.id] = await taskRepository.call(section.id);
            allGroupData.add(
              AppFlowyGroupData(
                id: section.id,
                name: section.name,
                items: tasksMap[section.id]!.map(
                  (e) {
                    if (e.description.isEmpty) {
                      return TextItem(e.content);
                    } else {
                      return RichTextItem(
                          title: e.content, subtitle: e.description);
                    }
                  },
                ).toList(),
              ),
            );
            controller.addGroup(allGroupData[sections.indexOf(section)]);
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
