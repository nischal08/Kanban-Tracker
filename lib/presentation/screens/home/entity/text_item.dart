import 'package:appflowy_board/appflowy_board.dart';

class TextItem extends AppFlowyGroupItem {
  final String s;

  TextItem(
    this.s,
  );

  @override
  String get id => s;
}

class RichTextItem extends AppFlowyGroupItem {
  final String title;
  final String subtitle;

  RichTextItem({required this.title, required this.subtitle});

  @override
  String get id => title;
}
