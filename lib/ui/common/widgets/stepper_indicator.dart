import 'package:flutter/material.dart';

import '/ui/common/index.dart';

class StepperIndicator extends StatelessWidget {
  final int index;
  final int numberOfSteps;

  const StepperIndicator({
    Key? key,
    required this.index,
    this.numberOfSteps = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: SizedBox()),
        for (int i = 0; i < numberOfSteps; i++) ...[
          if (i > 0) renderIndicator(i <= index),
          renderProgress(i <= index),
        ],
      ],
    );
  }

  Widget renderProgress(bool isCompleted) {
    return Icon(
      Icons.circle,
      size: 10,
      color: isCompleted ? secondaryColor : customLightGrey,
    );
  }

  Widget renderIndicator(bool isCompleted) {
    return Container(
      height: 2,
      width: 20,
      margin: const EdgeInsets.symmetric(horizontal: 1),
      decoration: BoxDecoration(
        color: isCompleted ? secondaryColor : customLightGrey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
