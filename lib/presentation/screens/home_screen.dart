import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kanban/core/styles/styles.dart';
import 'package:kanban_board/custom/board.dart';
import 'package:kanban_board/models/inputs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Kanban dashboard"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: KanbanBoard(
          List.generate(
            3,
            (index) => BoardListsData(
                backgroundColor: AppColors.boardBgColor,
                headerBackgroundColor: AppColors.boardBgColor,
                footerBackgroundColor: AppColors.boardBgColor,
                header: Padding(
                    padding: EdgeInsets.all(5.h),
                    child: Text(
                      "List Title",
                      style: generalTextStyle(20),
                    )),
                footer: Padding(
                    padding: EdgeInsets.all(5.h),
                    child: Text(
                      "List Footer",
                      style: generalTextStyle(20),
                    )),
                title: index == 1 ? "TODO" : "IN Progress",
                items: List.generate(
                  3,
                  (index) => Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.cardBorderColor,
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 0,
                              spreadRadius: 0,
                              offset: const Offset(1, 1),
                              color: Colors.grey.shade500.withOpacity(0.1))
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "Task ${index + 1}. Project setup",
                                style: TextStyle(
                                  fontSize: 19,
                                  height: 1.3,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ),
                            gapW(12),
                            const Icon(
                              Icons.more_vert,
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0, top: 4.0),
                          child: Transform.flip(
                              flipX: true,
                              child: const Icon(
                                Icons.segment_outlined,
                                size: 20,
                              )),
                        )
                      ],
                    ),
                  ),
                )),
          ),
          boardDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          onItemLongPress: (cardIndex, listIndex) {},
          onItemReorder:
              (oldCardIndex, newCardIndex, oldListIndex, newListIndex) {},
          onListLongPress: (listIndex) {},
          onListReorder: (oldListIndex, newListIndex) {},
          onItemTap: (cardIndex, listIndex) {},
          onListTap: (listIndex) {},
          onListRename: (oldName, newName) {},
          onNewCardInsert: (_, __, ___) {},
          backgroundColor: Colors.white,
          displacementY: 124,
          displacementX: 100,
          textStyle: TextStyle(
              fontSize: 19,
              height: 1.3,
              color: Colors.grey.shade800,
              fontWeight: FontWeight.w500),
          listDecoration: BoxDecoration(
            color: AppColors.boardBgColor,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
