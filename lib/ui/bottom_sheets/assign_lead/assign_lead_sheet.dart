import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '/ui/views/lead/record_audio.dart';
import '/ui/views/lead/remark.dart';
import '/ui/common/index.dart';
import '/ui/common/widgets/index.dart';
import '/ui/views/lead/all_leads/all_leads_viewmodel.dart';
import '/ui/views/lead/all_leads/all_leads_view.form.dart';

class AssignLeadSheet extends StackedView<AllLeadsViewModel>
    with $AllLeadsView {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const AssignLeadSheet({
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
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BottomSheetHeader(imageUrl: Images().leadProfileIcon),
                verticalSpaceTiny,
                Center(
                    child: Text('Assign Lead',
                        style: AppTextStyle().loadingLabelTextStyle)),
                verticalSpaceTiny,
                Text('Currently Assigned to',
                    style: AppTextStyle().buttonTextStyle(FontColor().grey)),
                verticalSpaceTiny,
                verticalSpaceTiny,
                Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: whiteColor),
                  child: Row(children: [
                    Image.asset(Images().clientImg, height: 32, width: 32),
                    horizontalSpaceSmall,
                    Text(
                        '${request.data['assignTo'] == 'Unassigned' ? 'No One' : request.data['assignTo']}',
                        style: AppTextStyle().inputLabelTextStyle()),
                  ]),
                ),
                verticalSpaceSmall,
                SelectDropList(
                  viewModel.entityOption,
                  viewModel.assignToUserList,
                  (optionItem) {
                    viewModel.onEntityChange(optionItem,
                        viewModel.assignToUserList.indexOf(optionItem));
                  },
                  labelText: 'Assign to',
                ),
                verticalSpaceSmall,
                Remark(viewModel: viewModel, controller: remarkController),
                verticalSpaceSmall,
                RecordAudio(viewModel: viewModel),
                verticalSpaceSmall,
                Button(
                    onPressed: () async {
                      await viewModel.assignLead(
                          leadId: request.data['leadId'],
                          assignToId: viewModel.assignToLeadId,
                          remark: remarkController.text);
                      completer!.call(SheetResponse(confirmed: true));
                    },
                    title: 'CONFIRM')
              ],
            ),
            if (viewModel.isBusy) ...[
              const SizedBox(
                  height: 500,
                  child: Center(
                      child: CircularProgressIndicator(color: primaryColor)))
            ],
          ],
        ),
      ),
    );
  }

  @override
  AllLeadsViewModel viewModelBuilder(BuildContext context) =>
      AllLeadsViewModel()..getActiveDSTListByLeadId(request.data['leadId']);
}
