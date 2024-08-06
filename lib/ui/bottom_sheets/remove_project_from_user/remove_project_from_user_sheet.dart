import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '/ui/common/index.dart';
import '/ui/common/widgets/index.dart';
import '/ui/views/allusers/allusers_viewmodel.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class RemoveProjectFromUserSheet extends StackedView<AllusersViewModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const RemoveProjectFromUserSheet({
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
      padding: const EdgeInsets.symmetric(horizontal: 15),
      constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height -
              (MediaQuery.of(context).size.height / 100) * 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: backgroundcolor),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            verticalSpaceTiny,
            verticalSpaceTiny,
            const BottomSheetHeader(
                headerText: 'Remove Project From Users', closeIconPadding: 10),
            verticalSpaceTiny,
            Text(
              'Showing your Team Members only',
              style: AppTextStyle().smallLarge(),
            ),
            verticalSpaceTiny,
            Padding(
              padding: const EdgeInsets.only(bottom: 16, top: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: FontColor().brown, width: 1),
                ),
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
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
                                  'Swarnamani',
                                  style: AppTextStyle().inputLabelTextStyle(),
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
                                Text('Kolkata', style: AppTextStyle().subTitle),
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
                            child: Text('8', style: AppTextStyle().titletext),
                          ),
                          verticalSpaceTiny,
                          Text(
                            'Leads',
                            style: AppTextStyle().textTitleStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: 2,
                scrollDirection: Axis.vertical,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SlidableTile(
                        valueKey: 1,
                        motion: const BehindMotion(),
                        action: [
                          Expanded(
                            child: Container(
                              decoration: const BoxDecoration(
                                color: secondaryColor,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                              ),
                              alignment: Alignment.center,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                          )
                        ],
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
                              Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  CircleAvatar(
                                      radius: 20,
                                      backgroundColor: greyShade100,
                                      child: Image.asset(Images().clientImg)),
                                  Positioned(
                                      top: 2,
                                      left: 28,
                                      child: CircleAvatar(
                                        backgroundColor: defaultgreen,
                                        radius: 6,
                                        child: SvgPicture.asset(
                                          Images().checkicon,
                                        ),
                                      ))
                                ],
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
                                          'Abhishek Dubey',
                                          style: AppTextStyle()
                                              .inputLabelTextStyle(),
                                        ),
                                        const Expanded(child: SizedBox()),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          Images().buildingIcon,
                                          height: 12,
                                          width: 15,
                                        ),
                                        horizontalSpaceTiny,
                                        Text(
                                          'Tribhuvan',
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
                                    child: Text('8',
                                        style: AppTextStyle().titletext),
                                  ),
                                  verticalSpaceTiny,
                                  Text(
                                    'Leads',
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                height: 50,
                child: Button(
                    onPressed: () {
                      completer!.call(SheetResponse(confirmed: true));
                    },
                    title: 'CLOSE'),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  AllusersViewModel viewModelBuilder(BuildContext context) =>
      AllusersViewModel();
}
