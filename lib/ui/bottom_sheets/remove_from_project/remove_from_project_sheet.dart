import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '/ui/common/index.dart';
import '/ui/common/widgets/index.dart';
import '/ui/views/allusers/allusers_viewmodel.dart';
import '/ui/views/allusers/allusers_view.form.dart';

class RemoveFromProjectSheet extends StackedView<AllusersViewModel>
    with $AllusersView {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const RemoveFromProjectSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AllusersViewModel viewModel,
    Widget? child,
  ) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: backgroundcolor),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const BottomSheetHeader(
                headerText: 'Remove from Project', closeIconPadding: 0),
            verticalSpaceSmall,
            UserRecords(
              actionUnavailable: false,
              path: currentTabIndex == 'CP'
                  ? Images().handShakeIcon
                  : Images().person,
              projectCount: 0,
              imageUrl: searchController.text.isNotEmpty
                  ? searchResponse[currentUserIndex]['profile_picture_url']
                      .toString()
                  : (currentTabIndex == 'DST'
                      ? dstResponse[currentUserIndex]['profile_picture_url']
                          .toString()
                      : currentTabIndex == 'CP'
                          ? cpResponse[currentUserIndex]['profile_picture_url']
                              .toString()
                          : myTeamResponse[currentUserIndex]
                                  ['profile_picture_url']
                              .toString()),
              designation: '',
              companyName: searchController.text.isNotEmpty
                  ? (currentTabIndex == 'CP'
                      ? searchResponse[currentUserIndex]['channel_partner_name']
                          .toString()
                      : searchResponse[currentUserIndex]['user_name']
                          .toString())
                  : (currentTabIndex == 'DST'
                      ? dstResponse[currentUserIndex]['user_name'].toString()
                      : currentTabIndex == 'CP'
                          ? cpResponse[currentUserIndex]['channel_partner_name']
                              .toString()
                          : myTeamResponse[currentUserIndex]['user_name']
                              .toString()),
              leads: 'Leads',
              leadsCount: searchController.text.isNotEmpty
                  ? searchResponse[currentUserIndex]['leads_count'].toString()
                  : (currentTabIndex == 'DST'
                      ? dstResponse[currentUserIndex]['leads_count'].toString()
                      : currentTabIndex == 'CP'
                          ? cpResponse[currentUserIndex]['leads_count']
                              .toString()
                          : myTeamResponse[currentUserIndex]['leads_count']
                              .toString()),
              location: assignedProjectSheetResponse[request.data['index']]
                      ['project_name']
                  .toString(),
              personName: searchController.text.isNotEmpty
                  ? (viewModel.sharedService.isCp!
                          ? searchResponse[currentUserIndex]['name']
                          : searchResponse[currentUserIndex]['user_name'])
                      .toString()
                  : (currentTabIndex == 'DST'
                      ? dstResponse[currentUserIndex]['user_name'].toString()
                      : currentTabIndex == 'CP'
                          ? (viewModel.sharedService.isCp!
                                  ? cpResponse[currentUserIndex]['name']
                                  : cpResponse[currentUserIndex]['user_name'])
                              .toString()
                          : myTeamResponse[currentUserIndex]['user_name']
                              .toString()),
              onTap: () {},
              onTapBuilding: () {},
              onTapRemove: () {},
            ),
            if (viewModel.isBusy && request.data['hasLead']) ...[
              Center(child: CircularProgressIndicator())
            ] else if (request.data['hasLead']) ...[
              verticalSpaceSmall,
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Assign existing leads to',
                  style: AppTextStyle().descriptionTextStyle(),
                ),
              ),
              verticalSpaceTiny,
              Row(
                children: [
                  renderSelectContainer(viewModel, 'Someone Else', 0, () {
                    viewModel.onSelect(0);
                  }),
                  horizontalSpaceSmall,
                  renderSelectContainer(viewModel, 'No One', 1, () {
                    viewModel.onSelect(1);
                  }),
                ],
              ),
              verticalSpaceSmall,
              viewModel.selectedIndex == 1
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.5),
                      child: Text(
                        '   All Leads of this user will be assigned\n to the Primary User of your Organisation',
                        style: AppTextStyle().textdescriptionstyle,
                      ),
                    )
                  : SizedBox(
                      child: SelectDropList(
                      entityOption,
                      AllusersViewModel().entityDropListModel,
                      (optionItem) {},
                    ))
            ],
            verticalSpaceSmall,
            SizedBox(
              height: 50,
              child: Button(
                  onPressed: () {
                    viewModel.onRemove(
                        context: context,
                        currentUserId: request.data['user_id'],
                        projectId: request.data['project_id'],
                        completer: completer);
                  },
                  title: 'REMOVE'),
            )
          ],
        ),
      ),
    );
  }

//Select container widget
  renderSelectContainer(AllusersViewModel viewModel, String? title, int index,
      void Function()? onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 45,
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: index == viewModel.selectedIndex ? lightpink : whiteColor,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                  color: index == viewModel.selectedIndex
                      ? primaryColor
                      : FontColor().brown),
              boxShadow: const [
                BoxShadow(
                    color: lightpink,
                    blurRadius: 10.0,
                    offset: Offset(7.0, 8.0))
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title!,
                style: AppTextStyle().buttonTextStyle(
                    index == viewModel.selectedIndex
                        ? primaryColor
                        : FontColor().grey2),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  AllusersViewModel viewModelBuilder(BuildContext context) =>
      AllusersViewModel();
}
