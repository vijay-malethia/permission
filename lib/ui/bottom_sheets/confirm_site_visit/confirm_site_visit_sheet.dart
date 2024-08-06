import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '/ui/common/index.dart';
import '/ui/common/widgets/index.dart';
import '/ui/views/scheduled_site_visits/scheduled_site_visits_view.form.dart';
import '/ui/views/scheduled_site_visits/scheduled_site_card.dart';
import '/ui/views/scheduled_site_visits/scheduled_site_visits_viewmodel.dart';

class ConfirmSiteVisitSheet extends StackedView<ScheduledSiteVisitsViewModel>
    with $ScheduledSiteVisitsView {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const ConfirmSiteVisitSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ScheduledSiteVisitsViewModel viewModel,
    Widget? child,
  ) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          color: backgroundcolor),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            verticalSpaceTiny,
            const BottomSheetHeader(
                headerText: 'Confirm Site Visit', closeIconPadding: 0),
            verticalSpaceSmall,
            ScheduledSiteCard(
              personName: capitalizeFirstLetter(request.data['lead_name']),
              date: viewModel.formatDate(request.data['stage_updated_ts']),
              location: request.data['project_name'][0] ?? '',
              companyName: request.data['assigned_to_name'] ?? '',
              clientVistDate:
                  viewModel.formatDate(request.data['followup_date']),
              statusBorderColor: Color(int.parse(
                  '0XFF${request.data['color_code_2'].toString().split('#').last}')),
              statusColor: Color(int.parse(
                  '0XFF${request.data['color_code_1'].toString().split('#').last}')),
              // vistDate: viewModel.scheduleSiteVisitsList[index]['dateCreated']??'',
              status: request.data['lead_stage'] ?? '',
              clientVistTime: request.data['followup_time'] ?? '',
              onTapCall: () {
                viewModel.showCallDialog(
                    capitalizeFirstLetter(request.data['lead_name']),
                    request.data['mobile_number']);
              },
            ),
            verticalSpaceSmall,
            verticalSpaceSmall,
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Client Code',
                  style: AppTextStyle().inputLabelTextStyle(),
                )),
            verticalSpaceSmall,
            OTPTextField(
                otpController: clientCodeController,
                onChanged: (p0) => viewModel.notifyListeners()),
            verticalSpaceLarge,
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'CP/User Code',
                  style: AppTextStyle().inputLabelTextStyle(),
                )),
            verticalSpaceSmall,
            OTPTextField(
                otpController: userCodeController,
                onChanged: (p0) => viewModel.notifyListeners()),
            verticalSpaceLarge,
            _renderButton(viewModel)
          ],
        ),
      ),
    );
  }

  @override
  ScheduledSiteVisitsViewModel viewModelBuilder(BuildContext context) =>
      ScheduledSiteVisitsViewModel()
        ..getSiteVisitCode(request.data['site_visited_detail_id']);

  _renderButton(ScheduledSiteVisitsViewModel viewmodel) {
    return SizedBox(
      height: 50,
      child: Button(
          onPressed: () async {
            await viewmodel.completeSiteVisit(
                followUpId: request.data['followup_id'],
                leadCode: int.parse(clientCodeController.text),
                userCode: int.parse(userCodeController.text));
            if (viewmodel.completeResult['code'] == 200) {
              completer!.call(SheetResponse(confirmed: true));
            }
            clientCodeController.clear();
            userCodeController.clear();
          },
          title: 'SUBMIT'),
    );
  }
}
