import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sales_lead/ui/common/index.dart';
import 'package:sales_lead/ui/common/widgets/index.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../views/allusers/allusers_viewmodel.dart';

class AssignedProjectsSheet extends StackedView<AllusersViewModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const AssignedProjectsSheet({
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
      height: screenHeight(context) * 0.7,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      constraints: BoxConstraints(maxHeight: screenHeight(context) * 0.7),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          color: backgroundcolor),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          verticalSpaceTiny,
          verticalSpaceTiny,
          const BottomSheetHeader(
              headerText: 'Assigned Projects', closeIconPadding: 10),
          if (currentTabIndex == 'DST') ...[
            Text(
              'Showing your projects only',
              style: AppTextStyle().smallLarge(),
            ),
          ],
          verticalSpaceTiny,
          Text(
            'Swipe a project towards left to remove',
            style: AppTextStyle().loadingDescriptionTextStyle,
          ),
          verticalSpaceSmall,
          verticalSpaceTiny,
          Expanded(
            child: ListView.builder(
                itemCount: assignedProjectSheetResponse.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(
                    decelerationRate: ScrollDecelerationRate.normal),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SlidableTile(
                        valueKey: index,
                        motion: const BehindMotion(),
                        action: request.data
                            ? [
                                Expanded(
                                  child: InkWell(
                                    onTap: () => viewModel
                                        .showRemoveFromProjectBottomSheet(
                                            index,
                                            int.parse(request.title!),
                                            assignedProjectSheetResponse[index]
                                                ['project_id'],
                                            (assignedProjectSheetResponse[index]
                                                        ['leadscount'] !=
                                                    null &&
                                                assignedProjectSheetResponse[
                                                        index]['leadscount'] >
                                                    0)),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: secondaryColor,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                      ),
                                      alignment: Alignment.center,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              Images().removeIcon,
                                              height: 18,
                                              width: 18,
                                            ),
                                            verticalSpaceTiny,
                                            Text(
                                              'Remove',
                                              style: AppTextStyle().textheading,
                                            )
                                          ]),
                                    ),
                                  ),
                                ),
                              ]
                            : [],
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 15),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                Images().buildingIcon,
                                height: 30,
                                width: 25,
                              ),
                              horizontalSpaceTiny,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          capitalizeFirstLetter(
                                              assignedProjectSheetResponse[
                                                  index]['project_name']),
                                          style: AppTextStyle()
                                              .inputLabelTextStyle(),
                                        ),
                                        const Expanded(child: SizedBox()),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          Images().locationIcon,
                                        ),
                                        horizontalSpaceTiny,
                                        Text(
                                          assignedProjectSheetResponse[index]
                                              ['city'],
                                          style: AppTextStyle().subTitle,
                                        ),
                                        const Expanded(child: SizedBox()),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: lightBgColor,
                                    child: Text(
                                        assignedProjectSheetResponse[index]
                                                ['leadscount']
                                            .toString(),
                                        style: AppTextStyle()
                                            .circleText(fontSize: 17)),
                                  ),
                                  verticalSpaceTiny,
                                  Text(
                                    'Lead',
                                    style: AppTextStyle().textTitleStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SizedBox(
              height: 50,
              child: Button(
                  onPressed: () =>
                      completer!.call(SheetResponse(confirmed: false)),
                  title: 'CLOSE'),
            ),
          )
        ],
      ),
    );
  }

  @override
  AllusersViewModel viewModelBuilder(BuildContext context) =>
      AllusersViewModel()..initAssignedProjectSheet(int.parse(request.title!));
}
