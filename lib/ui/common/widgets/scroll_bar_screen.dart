import 'package:flutter/material.dart';

import '../index.dart';

class ScrollBarScreen extends StatelessWidget {
  final Widget? headerChild;
  final Widget bodyChild;
  final ScrollController? scrollController;
  final double? height;
  final double? horizontalPadding;

  const ScrollBarScreen(
      {required this.bodyChild,
      this.headerChild,
      this.height,
      super.key,
      this.scrollController,
      this.horizontalPadding});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
            clipBehavior: Clip.hardEdge,
            controller: scrollController,
            slivers: [
          //app bar
          SliverAppBar(
              expandedHeight: height ?? 180,
              backgroundColor: backgroundcolor,
              elevation: 1,
              centerTitle: false,
              title: headerChild,
              automaticallyImplyLeading: false,
              pinned: true,
              flexibleSpace: Stack(
                children: [
                  Positioned.fill(
                    child: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        expandedTitleScale: 1,
                        background: SizedBox(
                            child: Image.asset(Images().loginBg,
                                fit: BoxFit.fill))),
                  ),
                  Positioned(
                    bottom: -7,
                    left: -1,
                    right: -1,
                    child: Container(
                      height: 20,
                      decoration: const BoxDecoration(
                          color: backgroundcolor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                    ),
                  )
                ],
              )),
          SliverToBoxAdapter(
              child: Container(
                  width: screenWidth(context),
                  padding:
                      EdgeInsets.symmetric(horizontal: horizontalPadding ?? 20),
                  color: backgroundcolor,
                  child: bodyChild))
        ]));
  }
}
