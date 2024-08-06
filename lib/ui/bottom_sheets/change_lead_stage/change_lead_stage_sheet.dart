import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '/ui/views/lead/record_audio.dart';
import '/ui/views/lead/remark.dart';
import '/ui/views/lead/all_leads/all_leads_view.form.dart';
import '/ui/common/index.dart';
import '/ui/common/widgets/index.dart';
import '/ui/views/lead/all_leads/all_leads_viewmodel.dart';

class ChangeLeadStageSheet extends StackedView<AllLeadsViewModel>
    with $AllLeadsView {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const ChangeLeadStageSheet({
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: backgroundcolor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BottomSheetHeader(
                imageUrl: Images().changeStageIcon,
                headerText: 'Change Lead Stage'),
            verticalSpaceMedium,
            Text('Current Stage',
                style: AppTextStyle().buttonTextStyle(FontColor().grey)),
            verticalSpaceTiny,
            verticalSpaceTiny,
            Container(
              height: 44,
              width: double.infinity,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  border: Border.all(color: borderColor),
                  borderRadius: BorderRadius.circular(8),
                  color: whiteColor),
              child: Text('${request.data['status']}',
                  style:
                      AppTextStyle().numberStyle(fontColor: FontColor().grey)),
            ),
            verticalSpaceSmall,
            verticalSpaceTiny,
            SelectDropList(
              viewModel.initLeadStage,
              viewModel.changeLeadStatus,
              (optionItem) {
                viewModel.changeLeadStage(
                    optionItem, viewModel.changeLeadStatus.indexOf(optionItem));
              },
              labelText: 'Change stage to',
            ),
            verticalSpaceSmall,
            Remark(viewModel: viewModel, controller: remarkController),
            verticalSpaceSmall,
            RecordAudio(viewModel: viewModel),
            verticalSpaceSmall,
            Button(
                onPressed: () async {
                  await viewModel.leadStageUpdate(
                      leadId: request.data['leadId'],
                      assignToId: viewModel.assignToLeadId,
                      remark: remarkController.text);
                  completer!.call(SheetResponse(confirmed: true));
                },
                title: 'CONFIRM')
          ],
        ),
      ),
    );
  }

  @override
  AllLeadsViewModel viewModelBuilder(BuildContext context) =>
      AllLeadsViewModel()..getLeadCurrentStages();
}
