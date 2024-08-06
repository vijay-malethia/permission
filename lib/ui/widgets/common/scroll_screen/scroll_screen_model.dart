import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '/ui/common/index.dart';

double scrollPositionThreshold = 80.0;

class ScrollScreenModel extends BaseViewModel {
  ScrollController scrollController = ScrollController();
  bool isExpanded = false;
  dismiss(BuildContext context) {
    dismissKeyboard(context);
    scrollController.animateTo(scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
    isExpanded = false;

    notifyListeners();
  }

  void onScroll() {
    if (scrollController.offset > scrollPositionThreshold) {
      isExpanded = true;
    } else {
      isExpanded = false;
    }
    notifyListeners();
  }
}
