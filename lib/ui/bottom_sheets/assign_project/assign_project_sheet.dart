import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

import '/ui/common/widgets/index.dart';
import '/ui/common/index.dart';
import '/ui/views/allusers/allusers_viewmodel.dart';

class AllUserAssignProjectSheet extends StackedView<AllusersViewModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const AllUserAssignProjectSheet({
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
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          color: backgroundcolor),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          verticalSpaceExtraSmall,
          const BottomSheetHeader(
              headerText: 'Assign Projects to User',
              showDrag: true,
              closeIconPadding: 15),
          Text(
            'Swipe a project towards left to assign',
            style: AppTextStyle().resendOtpTextStyle(),
          ),
          verticalSpaceSmall,
          Expanded(
            child: ListView.builder(
                itemCount: viewModel.assignProjectSheetResponse.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(
                    decelerationRate: ScrollDecelerationRate.normal),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Dismissible(
                        key: Key(viewModel.assignProjectSheetResponse[index]
                            ['project_name']),
                        onDismissed: (direction) {
                          viewModel.onAssign(
                            context: context,
                            index: index,
                            projectId:
                                viewModel.assignProjectSheetResponse[index]
                                    ['project_id'],
                            userId: int.parse(request.title!),
                          );
                        },
                        background: Row(
                          children: [
                            Spacer(),
                            Container(
                              decoration: const BoxDecoration(
                                color: secondaryColor,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                              ),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              alignment: Alignment.center,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.arrow_back,
                                      size: 17,
                                      color: whiteColor,
                                    ),
                                    Text(
                                      'Swipe left\nto assign',
                                      style: AppTextStyle().textheading,
                                      textAlign: TextAlign.center,
                                    )
                                  ]),
                            ),
                          ],
                        ),
                        direction: DismissDirection.endToStart,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                Images().buildingIcon,
                                height: 25,
                                width: 20,
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
                                          capitalizeFirstLetter(viewModel
                                                  .assignProjectSheetResponse[
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
                                          viewModel.assignProjectSheetResponse[
                                              index]['city'],
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
                                        viewModel
                                            .assignProjectSheetResponse[index]
                                                ['assigned_user_count']
                                            .toString(),
                                        style: AppTextStyle()
                                            .circleText(fontSize: 17)),
                                  ),
                                  verticalSpaceTiny,
                                  Text(
                                    'Users',
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
            child: Button(
                onPressed: () =>
                    completer!.call(SheetResponse(confirmed: false)),
                title: 'CLOSE'),
          )
        ],
      ),
    );
  }

  @override
  AllusersViewModel viewModelBuilder(BuildContext context) =>
      AllusersViewModel()..initAssignProjectSheet(int.parse(request.title!));
}
