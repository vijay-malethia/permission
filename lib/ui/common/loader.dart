import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sales_lead/ui/common/index.dart';

class Loader extends StatelessWidget {
  const Loader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container( 
     color: blackColor.withOpacity(0.4),
      child: Center(
            child: LoadingAnimationWidget.threeRotatingDots(color: whiteColor, size: 50)),
    );
  }
}