import 'package:sales_lead/ui/common/widgets/index.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '/ui/common/index.dart';
import '/ui/views/lead/all_leads/all_leads_viewmodel.dart';

class HistorySheet extends StackedView<AllLeadsViewModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const HistorySheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AllLeadsViewModel viewModel,
    Widget? child,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: backgroundcolor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
      child: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            BottomSheetHeader(
                headerText: 'History',
                imageUrl: Images().timerWithBg,
                showDrag: true),
            verticalSpaceMedium,
            _renderToolBar(context),
            verticalSpaceMedium,
            _renderHistory()
          ],
        ),
      ),
    );
  }

  @override
  AllLeadsViewModel viewModelBuilder(BuildContext context) =>
      AllLeadsViewModel();

  //History
  _renderHistory() => ListView.builder(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (ctx, index) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('01-Jul-2022',
                        style: AppTextStyle()
                            .resendOtpTextStyle(textColor: FontColor().grey)),
                    Text('10:30 AM', style: AppTextStyle().smallText()),
                  ],
                ),
                horizontalSpaceMedium,
                Column(
                  children: [
                    Container(
                      height: 7,
                      width: 6,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: borderColor),
                    ),
                    verticalSpaceTiny,
                    Container(width: 1, height: 31, color: lightGrey)
                  ],
                ),
                horizontalSpaceSmall,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Assigned to Ravi Kumar',
                        style: AppTextStyle().mediumSmallText()),
                    Text('by Ashok Gupta', style: AppTextStyle().smallLarge()),
                  ],
                ),
              ],
            ),
          ));

  //Render Tool Bar
  TabBar _renderToolBar(BuildContext context) {
    return TabBar(
        indicatorSize: TabBarIndicatorSize.label,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        tabs: [
          SizedBox(
              height: 25,
              child: Text('Assignment',
                  style: Theme.of(context).textTheme.labelSmall)),
          SizedBox(
              height: 25,
              child: Text('Lead Stages',
                  style: Theme.of(context).textTheme.labelSmall)),
        ],
        indicatorColor: primaryColor,
        labelColor: borderColor);
  }
}
