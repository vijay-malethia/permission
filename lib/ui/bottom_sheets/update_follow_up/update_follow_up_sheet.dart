import 'package:flutter/material.dart';
import 'package:sales_lead/ui/common/widgets/index.dart';
import 'package:sales_lead/ui/views/lead/all_leads/all_leads_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:sales_lead/ui/views/lead/remark.dart';
import 'package:sales_lead/ui/views/lead/record_audio.dart';
import '/ui/common/ui_helpers.dart';
import '/ui/views/lead/all_leads/all_leads_viewmodel.dart';
import '../../common/app_colors.dart';
import '../../common/app_fonts.dart';

class UpdateFollowUpSheet extends StackedView<AllLeadsViewModel>
    with $AllLeadsView {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const UpdateFollowUpSheet({
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
      margin: EdgeInsets.only(top: statusBarHeight(context) + 50),
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: backgroundcolor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const BottomSheetHeader(
                headerText: 'Update Follow Up', closeIconPadding: 0),
            verticalSpaceMedium,
            _selectOutcome(viewModel),
            verticalSpaceSmall,
            Remark(
                viewModel: viewModel,
                title: 'Follow Up Remarks',
                controller: followUpRemarkController),
            verticalSpaceSmall,
            Remark(
              viewModel: viewModel,
              title: 'Client Feedback',
              controller: followUpClientFeedbackController,
            ),
            verticalSpaceSmall,
            RecordAudio(viewModel: viewModel),
            verticalSpaceMedium,
            Button(
                onPressed: () {
                  viewModel.updateFollowUpStatus(
                      followUpId: request.data,
                      followupOutcome: viewModel.selectedOutcome == ''
                          ? null
                          : viewModel.selectedOutcome == 'Completed'
                              ? 1
                              : 2,
                      followUpRamarkAudio: followUpRemarkController.text,
                      followUpClientFeedBack:
                          followUpClientFeedbackController.text);
                },
                title: 'SUBMIT')
          ],
        ),
      ),
    );
  }

  @override
  AllLeadsViewModel viewModelBuilder(BuildContext context) =>
      AllLeadsViewModel();

  //Select Outcome design
  _selectOutcome(AllLeadsViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Outcome',
            style: AppTextStyle().buttonTextStyle(FontColor().grey)),
        verticalSpaceExtraSmall,
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => viewModel.selectOutcome('Completed'),
                child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: viewModel.selectedOutcome == 'Completed'
                                ? primaryColor
                                : borderColor),
                        color: viewModel.selectedOutcome == 'Completed'
                            ? lightPink
                            : whiteColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text('Completed',
                        style: AppTextStyle()
                            .numberStyle(fontColor: FontColor().grey))),
              ),
            ),
            horizontalSpaceSmall,
            Expanded(
              child: InkWell(
                onTap: () => viewModel.selectOutcome('Cancelled'),
                child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: viewModel.selectedOutcome == 'Cancelled'
                                ? primaryColor
                                : borderColor),
                        color: viewModel.selectedOutcome == 'Cancelled'
                            ? lightPink
                            : whiteColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text('Cancelled',
                        style: AppTextStyle()
                            .numberStyle(fontColor: FontColor().grey))),
              ),
            ),
          ],
        )
      ],
    );
  }
}
