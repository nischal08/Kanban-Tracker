import 'package:flutter/material.dart';

class AppUtils {
  const AppUtils._();

  /// For condition if list is max Scroll
  static bool infinityBottom(ScrollController scrollController) {
    if (!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
