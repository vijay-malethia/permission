import 'package:flutter/material.dart';
import 'package:sales_lead/ui/common/widgets/index.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '/ui/common/index.dart';
import '/ui/views/lead/all_leads/all_leads_viewmodel.dart';

class FollowUpFilterSheet extends StackedView<AllLeadsViewModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const FollowUpFilterSheet({
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
        color: whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const BottomSheetHeader(headerText: 'Filter By'),
          verticalSpaceMedium,
          _renderUnitType(viewModel),
          verticalSpaceSmall,
          _renderButton(viewModel)
        ],
      ),
    );
  }

  @override
  AllLeadsViewModel viewModelBuilder(BuildContext context) =>
      AllLeadsViewModel();

  //Render Unit Type
  _renderUnitType(AllLeadsViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Follow Up Type (${viewModel.countSelected()})',
            style: AppTextStyle().buttonTextStyle(FontColor().grey)),
        verticalSpaceTiny,
        verticalSpaceTiny,
        GridView.count(
          physics: const ScrollPhysics(),
          padding: const EdgeInsets.all(0),
          crossAxisCount: 3,
          childAspectRatio: (2.5 / 1.1),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          shrinkWrap: true,
          children: List.generate(4, (index) {
            return InkWell(
              onTap: () => viewModel.chooseAndClearFollowUpFilter(index: index),
              child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: followUpTypelist[index]['isSelected'] == true
                              ? primaryColor
                              : borderColor),
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(followUpTypelist[index]['name'],
                      style: AppTextStyle().numberStyle(
                          fontColor:
                              followUpTypelist[index]['isSelected'] == true
                                  ? primaryColor
                                  : FontColor().grey))),
            );
          }),
        )
      ],
    );
  }

  _renderButton(AllLeadsViewModel viewModel) {
    return Row(
      children: [
        Expanded(
            child: InkWell(
                onTap: () {
                  viewModel.chooseAndClearFollowUpFilter(
                      isClear: true, leadId: request.data);
                  completer!.call(
                      SheetResponse(confirmed: false, data: request.data));
                },
                child: Text(
                  'Clear Filter',
                  textAlign: TextAlign.center,
                  style: AppTextStyle().buttonTextStyle(borderColor),
                ))),
        horizontalSpaceMedium,
        Expanded(
            flex: 2,
            child: Button(
                onPressed: () {
                  completer!
                      .call(SheetResponse(confirmed: true, data: request.data));
                },
                title: 'SHOW RESULT'))
      ],
    );
  }
}
