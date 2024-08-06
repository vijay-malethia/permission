import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:sales_lead/ui/views/lead/all_leads/all_leads_view.form.dart';
import 'package:sales_lead/ui/views/lead/record_audio.dart';
import 'package:sales_lead/ui/views/lead/remark.dart';
import 'package:stacked/stacked.dart';

import '/model/lead_model.dart';
import '/ui/common/widgets/index.dart';
import '/ui/common/index.dart';
import '../all_leads/all_leads_viewmodel.dart';

class ScheduleView extends StackedView<AllLeadsViewModel> with $AllLeadsView {
  final LeadsModel userInfo;
  const ScheduleView({required this.userInfo, Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AllLeadsViewModel viewModel,
    Widget? child,
  ) {
    return Screen(
        height: 110,
        headerChild: _renderHeader(viewModel, context),
        bodyChild: _renderBody(viewModel, context));
  }

  @override
  AllLeadsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AllLeadsViewModel()..initSchedule(userInfo.followUpId);

  @override
  void onDispose(AllLeadsViewModel viewModel) {
    super.onDispose(viewModel);
    disposeForm();
  }

  //Header
  _renderHeader(AllLeadsViewModel viewModel, BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: InkWell(
          onTap: viewModel.goBack,
          child: Row(children: [
            const Icon(Icons.arrow_back, color: whiteColor),
            horizontalSpaceTiny,
            Text(
                '${userInfo.followUpId == null ? 'Schedule' : 'Edit'} Follow Up',
                style: Theme.of(context).textTheme.displayLarge)
          ]),
        ));
  }

//Render body
  _renderBody(AllLeadsViewModel viewModel, BuildContext context) =>
      SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                    width: 50,
                    height: 3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: customLightGrey)),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  _userInfoCard(),
                  verticalSpaceMedium,
                  _followUpType(viewModel),
                  verticalSpaceMedium,
                  _dateTimePicker(viewModel),
                  verticalSpaceMedium,
                  _renderNotify(viewModel),
                  verticalSpaceMedium,
                  Remark(
                    viewModel: viewModel,
                    controller: remarkScheduleController,
                  ),
                  verticalSpaceMedium,
                  RecordAudio(viewModel: viewModel),
                  // _recordAudio(context, viewModel),
                  verticalSpaceMedium,
                  _rederButton(viewModel)
                ])
              ],
            ),
            if (viewModel.isBusy)
              SizedBox(
                  height: screenHeight(context),
                  child: const Center(
                      child: CircularProgressIndicator(color: primaryColor)))
          ],
        ),
      );

  //Render Buttons
  _rederButton(AllLeadsViewModel viewModel) {
    return Row(
      children: [
        Expanded(
            child: InkWell(
                onTap: viewModel.resetSchedule,
                child: Text(
                  'Reset',
                  textAlign: TextAlign.center,
                  style: AppTextStyle().buttonTextStyle(borderColor),
                ))),
        horizontalSpaceMedium,
        Expanded(
            flex: 2,
            child: Button(
                onPressed: () {
                  userInfo.followUpId == null
                      ? viewModel.scheduleFollowup(
                          leadId: userInfo.leadId,
                          remark: remarkScheduleController.text)
                      : viewModel.editFollowUp(
                          followUpId: userInfo.followUpId,
                          leadId: userInfo.leadId,
                          remark: remarkScheduleController.text);
                },
                title: '${userInfo.followUpId == null ? 'CREATE' : 'UPDATE'} '))
      ],
    );
  }

  _renderNotify(AllLeadsViewModel viewModel) {
    return Column(
      children: [
        renderSwitch(viewModel, 'Notify Me'),
        verticalSpaceTiny,
        verticalSpaceTiny,
        if (viewModel.notifyMe)
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _renderCounter(
                    viewModel, 'Notify Me', viewModel.notifyMeCounter),
              ),
              horizontalSpaceExtraSmall,
              Expanded(
                  flex: 2,
                  child: DropDown(
                      onChanged: (value) =>
                          viewModel.onNotifyMeValueChange(value),
                      items: viewModel.notifyValueList,
                      value: viewModel.notifyMeValue)),
            ],
          ),
        verticalSpaceMedium,
        renderSwitch(viewModel, 'Notify Client'),
        verticalSpaceTiny,
        verticalSpaceTiny,
        if (viewModel.notifyClient)
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _renderCounter(
                    viewModel, 'Notify Client', viewModel.notifyClientCounter),
              ),
              horizontalSpaceExtraSmall,
              Expanded(
                  flex: 2,
                  child: DropDown(
                      onChanged: (value) =>
                          viewModel.onNotifyClientValueChange(value),
                      items: viewModel.notifyValueList,
                      value: viewModel.notifyClientValue)),
            ],
          ),
      ],
    );
  }

  Container _renderCounter(AllLeadsViewModel viewModel, name, counter) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: whiteColor,
          border: Border.all(width: 1, color: borderColor),
          borderRadius: BorderRadius.circular(5)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        InkWell(
            onTap: () => viewModel.changeCounterValue(name, false),
            child: const Icon(Icons.remove)),
        Text('$counter',
            style: AppTextStyle()
                .inputLabelTextStyle(fontColor: FontColor().grey)),
        InkWell(
            onTap: () => viewModel.changeCounterValue(name, true),
            child: const Icon(Icons.add))
      ]),
    );
  }

  Row renderSwitch(AllLeadsViewModel viewModel, name) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(name, style: AppTextStyle().buttonTextStyle(FontColor().grey)),
      FlutterSwitch(
        toggleColor: name == 'Notify Client'
            ? viewModel.notifyClient
                ? secondaryColor
                : lightBgColor2
            : viewModel.notifyMe
                ? secondaryColor
                : lightBgColor2,
        value: name == 'Notify Client'
            ? viewModel.notifyClient
            : viewModel.notifyMe,
        height: 22,
        width: 45,
        padding: 2,
        inactiveColor: lightBgColor,
        activeColor: lightBgColor,
        onToggle: (_) => viewModel.changeNotify(name),
      )
    ]);
  }

  _dateTimePicker(AllLeadsViewModel viewModel) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Date / Time',
              style: AppTextStyle().buttonTextStyle(FontColor().grey)),
          Icon(Icons.schedule, color: FontColor().grey, size: 20)
        ]),
        verticalSpaceTiny,
        verticalSpaceTiny,
        Row(
          children: [
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: () => viewModel.showDatePickerBottomSheet(
                    isEdit: userInfo.followUpId != null),
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: whiteColor,
                      border: Border.all(width: 1, color: borderColor),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(viewModel.date,
                            style: AppTextStyle()
                                .buttonTextStyle(FontColor().lightGrey)),
                        horizontalSpaceTiny,
                        SvgPicture.asset(Images().calenderMonth,
                            height: 20, width: 20)
                      ]),
                ),
              ),
            ),
            horizontalSpaceExtraSmall,
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () => viewModel.showTimePickerBottomSheet(true,
                    isEdit: userInfo.followUpId == null ? false : true),
                child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: whiteColor,
                        border: Border.all(width: 1, color: borderColor),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(viewModel.fromTime,
                        style: AppTextStyle()
                            .buttonTextStyle(FontColor().lightGrey))),
              ),
            ),
            horizontalSpaceExtraSmall,
            Expanded(
              child: InkWell(
                onTap: () {
                  if (viewModel.fromTime != 'From') {
                    viewModel.showTimePickerBottomSheet(false,
                        isEdit: userInfo.followUpId == null ? false : true);
                  }
                },
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: whiteColor,
                      border: Border.all(width: 1, color: borderColor),
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(viewModel.toTime,
                      style: AppTextStyle()
                          .buttonTextStyle(FontColor().lightGrey)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

//Render Follow Up Type
  _followUpType(AllLeadsViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Follow Up Type',
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
          children: List.generate(followUpTypelist.length, (index) {
            return InkWell(
              onTap: () => viewModel.selectFollowUpType(index),
              child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: viewModel.selectedFollowTypeIndex == index
                              ? primaryColor
                              : borderColor),
                      color: viewModel.selectedFollowTypeIndex == index
                          ? lightpink
                          : whiteColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(followUpTypelist[index]['name'],
                      style: AppTextStyle().descriptionTextStyle())),
            );
          }),
        )
      ],
    );
  }

//User info Card
  _userInfoCard() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: whiteColor,
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 5),
                color: greyShade300,
                blurRadius: 5,
                spreadRadius: -5)
          ],
          borderRadius: BorderRadius.circular(8)),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(userInfo.personName,
                  style: AppTextStyle()
                      .inputLabelTextStyle(fontColor: FontColor().grey)),
              Container(
                  width: 90,
                  height: 22,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: userInfo.backgroundColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: userInfo.borderColor)),
                  child:
                      Text(userInfo.status, style: AppTextStyle().eightPixel))
            ]),
            Row(children: [
              SvgPicture.asset(Images().buildingIcon),
              horizontalSpaceTiny,
              Text(userInfo.location,
                  style: AppTextStyle()
                      .textButtonTextStyle(textColor: FontColor().brown)),
              const Expanded(child: SizedBox()),
              Text(userInfo.date, style: AppTextStyle().smallestTest),
              const SizedBox(width: 17)
            ]),
          ]),
    );
  }
}
