import 'package:flutter/material.dart';
import 'package:sales_lead/ui/common/widgets/index.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '/ui/common/index.dart';
import '/ui/views/lead/all_leads/all_leads_viewmodel.dart';

class FilterSheet extends StackedView<AllLeadsViewModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const FilterSheet({
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
      margin: EdgeInsets.only(top: statusBarHeight(context) + 50),
      decoration: const BoxDecoration(
        color: backgroundcolor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              BottomSheetHeader(
                  ontap: () {
                    completer!.call(SheetResponse(confirmed: false));
                  },
                  headerText: 'Filter By',
                  closeIconPadding: 0),
              if (request.data['tabIndex'] == 0) ...[
                Text('Status',
                    style: AppTextStyle().buttonTextStyle(FontColor().grey)),
                verticalSpaceSmall,
                _renderStatus(viewModel)
              ],
              verticalSpaceMedium,
              Text('Projects',
                  style: AppTextStyle().buttonTextStyle(FontColor().grey)),
              verticalSpaceExtraSmall,
              _renderProject(viewModel,
                  selectedItemList: selectedProjectList,
                  itemList: projectList,
                  isUserList: false,
                  context: context,
                  isListHide: viewModel.isProjectListHide),
              if (isAssigned != 'Unassigned' &&
                  request.data['tabIndex'] != 2) ...[
                verticalSpaceMedium,
                Text(
                    !request.data['userType'] && request.data['tabIndex'] == 1
                        ? 'Channel Partners'
                        : 'Users',
                    style: AppTextStyle().buttonTextStyle(FontColor().grey)),
                verticalSpaceExtraSmall,
                _renderProject(viewModel,
                    context: context,
                    selectedItemList: !request.data['userType'] &&
                            request.data['tabIndex'] == 1
                        ? selectedCpIdsList
                        : selectedUserList,
                    itemList: !request.data['userType'] &&
                            request.data['tabIndex'] == 1
                        ? channelPartnersList
                        : userList,
                    isUserList: true,
                    isListHide: viewModel.isUserListHide),
              ],
              verticalSpaceMedium,
              _renderButton(viewModel)
            ],
          ),
          if (viewModel.isBusy)
            const SizedBox(
                height: 350,
                child: Center(
                    child: CircularProgressIndicator(color: primaryColor)))
        ],
      ),
    );
  }

  @override
  AllLeadsViewModel viewModelBuilder(BuildContext context) =>
      AllLeadsViewModel();

  _renderProject(AllLeadsViewModel viewModel,
      {selectedItemList, itemList, isUserList, isListHide, context}) {
    return Column(
      children: [
        InkWell(
          onTap: () => viewModel.showHideLis(isUserList),
          child: Container(
              height: selectedItemList.isEmpty ? 42 : null,
              width: double.infinity,
              padding: const EdgeInsets.only(top: 5, left: 5),
              decoration: BoxDecoration(
                  color: whiteColor,
                  border: Border.all(color: borderColor),
                  borderRadius: BorderRadiusDirectional.circular(5)),
              child: Wrap(
                children: List.generate(
                    selectedItemList.length,
                    (index) => newMethod(index, selectedItemList, viewModel,
                        isUserList, context)),
              )),
        ),
        if (!isListHide)
          Container(
              height: 200,
              decoration: BoxDecoration(
                  border: Border.all(color: borderColor),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: itemList.length,
                  physics: const ScrollPhysics(),
                  itemBuilder: (ctx, index) => InkWell(
                        onTap: () => viewModel.addUserToList(index, isUserList),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          margin: const EdgeInsets.all(2),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: backgroundcolor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(itemList[index]['name'],
                              style: AppTextStyle().tncTextStyle(),
                              maxLines: 3,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis),
                        ),
                      )))
      ],
    );
  }

  Container newMethod(
      index, selectedList, AllLeadsViewModel viewModel, isUserList, context) {
    return Container(
        height: 30,
        margin: const EdgeInsets.only(right: 5, bottom: 5),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            color: lightBrown,
            borderRadius: BorderRadiusDirectional.circular(5)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: screenWidth(context) * 0.7),
              child: Text(selectedList[index]['name'],
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle().buttonTextStyle(FontColor().black)),
            ),
            horizontalSpaceTiny,
            GestureDetector(
                onTap: () =>
                    viewModel.removeFromSelectedList(index, isUserList),
                child: const Icon(Icons.close, color: whiteColor, size: 18))
          ],
        ));
  }

  _renderButton(AllLeadsViewModel viewModel) {
    return Row(
      children: [
        Expanded(
            child: InkWell(
                onTap: () {
                  completer!.call(SheetResponse(confirmed: false));
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
                  completer!.call(SheetResponse(confirmed: true, data: {
                    'userList': selectedUserList,
                    'projectList': selectedProjectList,
                    'assigned': isAssigned,
                    'cpList': selectedCpIdsList
                  }));
                },
                title: 'SHOW RESULT'))
      ],
    );
  }

  _renderStatus(AllLeadsViewModel viewModel) {
    return Row(
      children: [
        Expanded(child: statusButton(viewModel, name: 'Assigned')),
        horizontalSpaceSmall,
        Expanded(child: statusButton(viewModel, name: 'Unassigned')),
      ],
    );
  }

  InkWell statusButton(AllLeadsViewModel viewModel, {name}) {
    return InkWell(
      onTap: () => viewModel.changeStatus(name),
      child: Container(
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: isAssigned == name ? lightpink : whiteColor,
              border: Border.all(
                  color: isAssigned == name ? primaryColor : borderColor),
              borderRadius: BorderRadiusDirectional.circular(5)),
          child: Text(name, style: AppTextStyle().loadingDescriptionTextStyle)),
    );
  }
}
