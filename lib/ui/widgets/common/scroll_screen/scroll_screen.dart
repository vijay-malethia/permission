import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/index.dart';
import 'scroll_screen_model.dart';

class ImageScrollBarHeader extends StackedView<ScrollScreenModel> {
  final String? headerTitle;
  final Widget bodyChild;
  final double? horizontalPadding;
  final bool isMinimum;
  final bool isRegistration;
  final void Function()? onBackArrowTap;
  final String? userCreationType;

  const ImageScrollBarHeader(
      {required this.bodyChild,
      this.headerTitle,
      required this.onBackArrowTap,
      this.isRegistration = false,
      this.horizontalPadding,
      this.isMinimum = false,
      this.userCreationType,
      super.key});

  @override
  Widget builder(
    BuildContext context,
    ScrollScreenModel viewModel,
    Widget? child,
  ) {
    if (isMinimum) {
      scrollPositionThreshold = 10;
    } else {
      scrollPositionThreshold = 80;
    }
    return Scaffold(
        body: GestureDetector(
      onTap: () {
        viewModel.dismiss(context);
      },
      child: CustomScrollView(
          clipBehavior: Clip.hardEdge,
          controller: viewModel.scrollController,
          slivers: [
            SliverAppBar(
                expandedHeight: isMinimum
                    ? screenHeight(context) * 0.12
                    : 180 - statusBarHeight(context),
                backgroundColor: backgroundcolor,
                elevation: 1,
                centerTitle: false,
                title: viewModel.isExpanded
                    ? Header(
                        viewModel: viewModel,
                        onBackArrowTap: onBackArrowTap,
                        isRegistration: isRegistration,
                        userCreationType: userCreationType,
                        headerTitle: headerTitle,
                      )
                    : null,
                automaticallyImplyLeading: false,
                pinned: true,
                flexibleSpace: Stack(
                  children: [
                    Positioned.fill(
                      child: FlexibleSpaceBar(
                          collapseMode: CollapseMode.parallax,
                          expandedTitleScale: 1,
                          background: Stack(
                            children: [
                              isMinimum
                                  ? Container(
                                      decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color.fromARGB(255, 26, 48, 88),
                                          Color.fromARGB(255, 29, 58, 95),
                                          Color.fromARGB(255, 78, 81, 105),
                                        ],
                                      )),
                                    )
                                  : SizedBox(
                                      width: double.infinity,
                                      child: Image.asset(Images().loginBg,
                                          fit: BoxFit.fitWidth)),
                              Container(
                                  alignment: Alignment.topCenter,
                                  color: Colors.black26,
                                  padding: const EdgeInsets.only(left: 20),
                                  child: viewModel.isExpanded
                                      ? null
                                      : Header(
                                          viewModel: viewModel,
                                          onBackArrowTap: onBackArrowTap,
                                          isRegistration: isRegistration,
                                          userCreationType: userCreationType,
                                          headerTitle: headerTitle,
                                        ))
                            ],
                          )),
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
                child: Focus(
              onFocusChange: (value) {
                if (!value) {
                  viewModel.dismiss(context);
                }
              },
              child: Container(
                  width: screenWidth(context),
                  padding:
                      EdgeInsets.symmetric(horizontal: horizontalPadding ?? 20),
                  color: backgroundcolor,
                  child: bodyChild),
            ))
          ]),
    ));
  }

  @override
  ScrollScreenModel viewModelBuilder(
    BuildContext context,
  ) =>
      ScrollScreenModel();
  @override
  void onViewModelReady(ScrollScreenModel viewModel) {
    viewModel.scrollController.addListener(viewModel.onScroll);
    super.onViewModelReady(viewModel);
  }
}

class Header extends StatefulWidget {
  final ScrollScreenModel viewModel;

  final String? headerTitle;

  final bool isRegistration;
  final void Function()? onBackArrowTap;
  final String? userCreationType;
  const Header(
      {this.headerTitle,
      required this.viewModel,
      required this.onBackArrowTap,
      this.isRegistration = false,
      this.userCreationType,
      super.key});

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  _HeaderState();

  @override
  void initState() {
    super.initState();
    expandController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.easeIn,
    );
    _runExpandCheck();
  }

  void _runExpandCheck() async {
    await expandController.forward();
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(children: [
            GestureDetector(
              onTap: widget.onBackArrowTap,
              child: Container(
                transformAlignment: Alignment.center,
                alignment: widget.isRegistration
                    ? Alignment.topCenter
                    : Alignment.center,
                child: Icon(Icons.arrow_back,
                    size: 30,
                    color: widget.viewModel.isExpanded
                        ? borderColor
                        : Colors.white),
              ),
            ),
            horizontalSpaceTiny,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.isRegistration) ...[
                  Text('REGISTER',
                      style: AppTextStyle().agreementTitleTextStyle(
                          fontColor: widget.viewModel.isExpanded
                              ? borderColor
                              : Colors.white)),
                  Text('as ${widget.userCreationType}',
                      style: AppTextStyle().agreementSubtitleTextStyle(
                          fontColor: widget.viewModel.isExpanded
                              ? borderColor
                              : Colors.white)),
                ],
                if (!widget.isRegistration) ...[
                  Text('${widget.headerTitle}',
                      style: AppTextStyle().agreementTitleTextStyle(
                          fontColor: widget.viewModel.isExpanded
                              ? borderColor
                              : Colors.white))
                ]
              ],
            ),
          ]),
        ],
      ),
    );
  }
}

// _renderHeader(ScrollScreenModel viewModel, context) {
//   return Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       Row(children: [
//         GestureDetector(
//           onTap: onBackArrowTap,
//           child: Container(
//             height: 50,
//             padding: EdgeInsets.only(top: isRegistration ? 5 : 0),
//             margin: EdgeInsets.only(
//                 top: isRegistration ? 0 : statusBarHeight(context) - 10),
//             alignment:
//                 isRegistration ? Alignment.topCenter : Alignment.center,
//             child: Icon(Icons.arrow_back,
//                 size: 30,
//                 color: viewModel.isExpanded ? borderColor : Colors.white),
//           ),
//         ),
//         horizontalSpaceTiny,
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (isRegistration) ...[
//               Text('REGISTER',
//                   style: AppTextStyle().agreementTitleTextStyle(
//                       fontColor:
//                           viewModel.isExpanded ? borderColor : Colors.white)),
//               Text('as $userCreationType',
//                   style: AppTextStyle().agreementSubtitleTextStyle(
//                       fontColor:
//                           viewModel.isExpanded ? borderColor : Colors.white)),
//             ],
//             if (!isRegistration) ...[
//               Container(
//                 padding: EdgeInsets.only(top: statusBarHeight(context) - 10),
//                 child: Text('$headerTitle',
//                     style: AppTextStyle().agreementTitleTextStyle(
//                         fontColor: viewModel.isExpanded
//                             ? borderColor
//                             : Colors.white)),
//               )
//             ]
//           ],
//         ),
//       ]),
//     ], // ignore_for_file: no_logic_in_create_state, library_private_types_in_public_api
//   );
// }
