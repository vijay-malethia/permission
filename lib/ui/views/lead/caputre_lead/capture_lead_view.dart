import 'package:flutter/material.dart';
import 'package:sales_lead/ui/views/lead/record_audio.dart';
import 'package:sales_lead/ui/views/lead/remark.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '/ui/widgets/common/scroll_screen/scroll_screen.dart';
import '/ui/common/widgets/index.dart';
import '/ui/common/index.dart';
import 'capture_lead_view.form.dart';
import 'capture_lead_viewmodel.dart';

@FormView(fields: [
  FormTextField(name: 'name', validator: FormValidator.validateName),
  FormTextField(name: 'emailId'),
  FormTextField(name: 'mobile', validator: FormValidator.validatePhoneNumber),
  FormTextField(name: 'remark')
])
class CaptureLeadView extends StackedView<CaptureLeadViewModel>
    with $CaptureLeadView {
  const CaptureLeadView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CaptureLeadViewModel viewModel,
    Widget? child,
  ) {
    return ImageScrollBarHeader(
        bodyChild: _renderBody(viewModel, context),
        onBackArrowTap: viewModel.goBack,
        isMinimum: false,
        horizontalPadding: 0,
        headerTitle: 'Capture Lead');
  }

  @override
  CaptureLeadViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CaptureLeadViewModel();

  @override
  void onViewModelReady(CaptureLeadViewModel viewModel) {
    syncFormWithViewModel(viewModel);
  }

  @override
  void onDispose(CaptureLeadViewModel viewModel) {
    super.onDispose(viewModel);
    disposeForm();
  }

  //Render Body
  _renderBody(CaptureLeadViewModel viewModel, BuildContext context) => viewModel
          .isBusy
      ? const Center(child: CircularProgressIndicator())
      : SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: 3,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: customLightGrey)),
              verticalSpaceMedium,
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: InputWithLabel(
                    labelText: 'Name',
                    controller: nameController,
                  )),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                alignment: Alignment.centerLeft,
                child: Visibility(
                  visible: viewModel.hasNameValidationMessage,
                  child: Text(
                    viewModel.nameValidationMessage ?? '',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
              verticalSpaceMedium,
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: InputWithLabel(
                      labelText: 'Email ID', controller: emailIdController)),
              verticalSpaceMedium,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: InputWithLabel(
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  labelText: 'Mobile',
                  controller: mobileController,
                  prefixIcon: SizedBox(
                    height: 30,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            '+ 91',
                            style: AppTextStyle().countryCodeTextStyle,
                          ),
                        ),
                        horizontalSpaceTiny,
                        Container(
                            width: 1, height: 30, color: FontColor().lightGrey),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                alignment: Alignment.centerLeft,
                child: Visibility(
                  visible: viewModel.hasMobileValidationMessage,
                  child: Text(
                    viewModel.mobileValidationMessage ?? '',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
              verticalSpaceMedium,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                    child: SelectDropList(
                  viewModel.entityOption,
                  viewModel.projectList,
                  (index) {
                    viewModel
                        .onEntityChange(viewModel.projectList.indexOf(index));
                  },
                  labelText: 'Project',
                )),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                alignment: Alignment.centerLeft,
                child: Visibility(
                    visible: viewModel.entityOption.title == '' ? true : false,
                    child: const Text('Required',
                        style: TextStyle(color: Colors.red))),
              ),
              if (viewModel.unitTypeList.isNotEmpty) ...[
                verticalSpaceMedium,
                _renderUnitType(viewModel), //Render Unit Type
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  alignment: Alignment.centerLeft,
                  child: Visibility(
                      visible: viewModel.unitTypeindex == -1 ? true : false,
                      child: const Text('Required',
                          style: TextStyle(color: Colors.red))),
                ),
              ],
              verticalSpaceMedium,
              _renderFloorPreference(viewModel), //Render Floor Preference
              verticalSpaceMedium,
              Remark(
                  model: viewModel,
                  controller: remarkController,
                  isAllLeadScreen: false),
              verticalSpaceMedium,
              RecordAudio(model: viewModel, isAllLeadScreen: false),
              verticalSpaceMedium,
              _rederButton(viewModel), //Render Buttons
              verticalSpaceMedium
            ],
          ),
        );

  //Render Unit Type
  _renderUnitType(CaptureLeadViewModel viewModel) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            alignment: Alignment.centerLeft,
            child:
                Text('Unit Type', style: AppTextStyle().inputLabelTextStyle())),
        verticalSpaceTiny,
        verticalSpaceTiny,
        GridView.count(
          physics: const ScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          crossAxisCount: 3,
          childAspectRatio: (2.5 / 1.1),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          shrinkWrap: true,
          children: List.generate(viewModel.unitTypeList.length, (index) {
            return InkWell(
              onTap: () => viewModel.changeUnitType(index),
              child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: viewModel.unitTypeindex == index
                              ? primaryColor
                              : borderColor),
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Text(
                      '${viewModel.unitTypeList[index]['unit_type_name']}',
                      style: AppTextStyle().numberStyle(
                          fontColor: viewModel.unitTypeindex == index
                              ? primaryColor
                              : FontColor().grey))),
            );
          }),
        )
      ],
    );
  }

  //Render Floor Prefrence
  _renderFloorPreference(CaptureLeadViewModel viewModel) => Column(
        children: [
          Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text('Floor Preference',
                  style: AppTextStyle().inputLabelTextStyle())),
          verticalSpaceTiny,
          verticalSpaceTiny,
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      SfRangeSlider(
                          startThumbIcon: const Icon(Icons.circle,
                              size: 18, color: primaryColor),
                          endThumbIcon: Container(
                              decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(10))),
                          min: viewModel.minFloor,
                          max: viewModel.maxFloor,
                          activeColor: leadActive,
                          inactiveColor: leaceInactive,
                          values: viewModel.floorRange,
                          minorTicksPerInterval: 1,
                          interval: 1,
                          onChanged: (value) => viewModel.changeflorr(value)),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, right: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(viewModel.minFloor.toString()[0],
                                style: AppTextStyle().ligthEightPixel(
                                    fontColor: FontColor().grey2)),
                            Text(viewModel.maxFloor.toString()[0],
                                style: AppTextStyle().ligthEightPixel(
                                    fontColor: FontColor().grey2))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  alignment: Alignment.center,
                  height: 44,
                  decoration: BoxDecoration(
                      border: Border.all(color: borderColor),
                      borderRadius: BorderRadius.circular(5),
                      color: whiteColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          viewModel.floorRange.start
                              .toString()
                              .split('.')
                              .first,
                          style: AppTextStyle().descriptionTextStyle(
                              fontColor: FontColor().grey2)),
                      Text('th', style: AppTextStyle().dash),
                      Text(
                          "- ${viewModel.floorRange.end.toString().split('.').first}",
                          style: AppTextStyle().descriptionTextStyle(
                              fontColor: FontColor().grey2)),
                      Text('th', style: AppTextStyle().dash),
                    ],
                  ),
                ))
              ],
            ),
          ),
        ],
      );

  //Render Buttons
  _rederButton(CaptureLeadViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        children: [
          Expanded(
              child: InkWell(
                  onTap: viewModel.resetData,
                  child: Text(
                    'Reset',
                    textAlign: TextAlign.center,
                    style: AppTextStyle().buttonTextStyle(borderColor),
                  ))),
          horizontalSpaceMedium,
          Expanded(
              flex: 2,
              child: Button(onPressed: viewModel.createLead, title: 'SUBMIT'))
        ],
      ),
    );
  }
}
