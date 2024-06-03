import 'dart:developer';

import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kanban/core/styles/app_sizes.dart';
import 'package:kanban/core/styles/text_styles.dart';
import 'package:kanban/presentation/bloc/section/section_bloc.dart';
import 'package:kanban/presentation/models/task_model.dart';
import 'package:kanban/presentation/screens/home/entity/text_item.dart';
import 'package:kanban/presentation/screens/home/widgets/confirmation_dialog.dart';

class AllBoard extends StatefulWidget {
  const AllBoard({super.key});

  @override
  State<AllBoard> createState() => _AllBoardState();
}

class _AllBoardState extends State<AllBoard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final config = AppFlowyBoardConfig(
      groupBackgroundColor: HexColor.fromHex('#F7F8FC'),
      stretchGroupHeight: false,
      boardCornerRadius: 16.r,
      groupCornerRadius: 8.r,
    );
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppFlowyBoard(
          controller: context.watch<SectionBloc>().controller,
          cardBuilder: (context, group, groupItem) {
            log(group.id);
            return AppFlowyGroupCard(
              margin: EdgeInsets.only(
                top: 12.h,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.r),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1,
                    spreadRadius: 1,
                    offset: const Offset(1, 2),
                    color: Colors.grey.shade500.withOpacity(0.1),
                  ),
                ],
              ),
              key: ValueKey(groupItem.id),
              child: _buildCard(group, groupItem),
            );
          },
          boardScrollController: context.watch<SectionBloc>().boardController,
          footerBuilder: (context, columnData) {
            return AppFlowyGroupFooter(
              icon: Icon(Icons.add, size: 16.h),
              title: const Text('New'),
              height: 40.h,
              margin: config.groupBodyPadding,
              onAddButtonClick: () {
                //TODO: add new card
                context.read<SectionBloc>().controller.addGroupItem(
                      columnData.headerData.groupId,
                      RichTextItem(title: "Hello1", subtitle: "how are you"),
                    );
                context
                    .read<SectionBloc>()
                    .boardController
                    .scrollToBottom(columnData.id);
              },
            );
          },
          headerBuilder: (context, columnData) {
            return Column(
              children: [
                AppFlowyGroupHeader(
                  icon: const Icon(Icons.lightbulb_circle),
                  onMoreButtonClick: () {
                    //TODO: add menu logic include edit
                  },
                  title: Expanded(
                    child: Text(
                      columnData.headerData.groupName,
                      style: generalTextStyle(16),
                    ),
                  ),
                  moreIcon: Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 50.w),
                      child: Icon(
                        Icons.more_horiz,
                        size: 18.h,
                      ),
                    ),
                  ),
                  margin: config.groupBodyPadding,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 12.w),
                  height: 0.5,
                  width: double.infinity,
                  color: Colors.grey.shade400,
                )
              ],
            );
          },
          groupConstraints: BoxConstraints.tightFor(width: 230.w),
          config: config),
    );
  }

  Widget _buildCard(AppFlowyGroupData group, AppFlowyGroupItem item) {
    SectionBloc sectionBloc = BlocProvider.of<SectionBloc>(context);
    TaskModel taskData = (sectionBloc.state as SectionSuccessState)
        .tasks[group.headerData.groupId]!
        .firstWhere((element) => element.content == item.id);
    return GestureDetector(
      onTap: () async {
        //TODO: remaining to code for edit data
        await showDialog(
            context: context,
            builder: (BuildContext dgContext) {
              return const BoardCardEditDialog();
            });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 4.w,
          vertical: 4.h,
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 5.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.r),
                  color: Colors.green,
                ),
              ),
              gapW(8),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 8.h,
                    bottom: 4.h,
                    right: 4.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichTextCard(item: item),
                      gapH(6),
                      Container(
                        height: 0.5,
                        // width: double.maxFinite,
                        color: Colors.grey.shade400,
                      ),
                      gapH(4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "ID ${taskData.id}",
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.comment_outlined,
                                color: Colors.grey,
                                size: 15.h,
                              ),
                              gapW(2),
                              Text(
                                taskData.commentCount.toString(),
                              ),
                              gapW(4),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RichTextCard extends StatefulWidget {
  final AppFlowyGroupItem item;
  const RichTextCard({
    required this.item,
    super.key,
  });

  @override
  State<RichTextCard> createState() => _RichTextCardState();
}

class _RichTextCardState extends State<RichTextCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          (widget.item is TextItem)
              ? (widget.item as TextItem).s
              : (widget.item as RichTextItem).title,
          style: generalTextStyle(14),
        ),
        if (widget.item is RichTextItem)
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Text(
              (widget.item as RichTextItem).subtitle,
              overflow: TextOverflow.ellipsis,
              style: generalTextStyle(12).copyWith(
                color: Colors.grey,
              ),
            ),
          ),
      ],
    );
  }
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
