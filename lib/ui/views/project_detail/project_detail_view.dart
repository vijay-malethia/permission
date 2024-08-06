import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

import '/ui/widgets/common/scroll_screen/scroll_screen.dart';
import '/ui/common/index.dart';
import '/ui/views/all_project/all_project_viewmodel.dart';

class ProjectDetailView extends StackedView<AllProjectViewModel> {
  final int projectId;
  const ProjectDetailView({required this.projectId, Key? key})
      : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AllProjectViewModel viewModel,
    Widget? child,
  ) {
    return ImageScrollBarHeader(
        bodyChild: _renderBody(context, viewModel),
        onBackArrowTap: viewModel.back,
        headerTitle: 'Project Overview',
        horizontalPadding: 0);
  }

  @override
  AllProjectViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AllProjectViewModel()..initProjectDetailView(projectId);
}

//render app no. or users and leads count
Container _renderUserAndLeads(AllProjectViewModel viewModel) {
  return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: borderColor),
        boxShadow: const [
          BoxShadow(
            color: black12,
            blurRadius: 1.0,
            spreadRadius: 1,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${viewModel.sharedService.isCp! ? viewModel.projectDetailResponse['usercount_cp'].toString() : (currentTabIndex == 1 ? viewModel.projectDetailResponse['usercount_dst'].toString() : viewModel.projectDetailResponse['usercount_cp'].toString())} Users',
            style: AppTextStyle().buttonTextStyle(borderColor),
          ),
          Container(
              width: 2,
              height: 15,
              color: borderColor,
              margin: const EdgeInsets.symmetric(horizontal: 10)),
          Text(
            '${viewModel.sharedService.isCp! ? viewModel.projectDetailResponse['leadcount_cp'].toString() : (currentTabIndex == 1 ? viewModel.projectDetailResponse['leadcount_dst'].toString() : viewModel.projectDetailResponse['leadcount_cp'].toString())} Leads',
            style: AppTextStyle().buttonTextStyle(borderColor),
          )
        ],
      ));
}

//
_renderCard(BuildContext context,
    {String? title,
    String? icon,
    double? height,
    double? width,
    String? subTitle,
    final void Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      // height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: greyShade100,
            blurRadius: 1.0,
            spreadRadius: 1,
            offset: Offset(2, 2),
          )
        ],
      ),

      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(capitalizeFirstLetter(title!),
            style: AppTextStyle()
                .toastMessageTextStyle(fontColor: FontColor().grey)),
        subtitle: Container(
          margin: const EdgeInsets.only(top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Text(
                  capitalizeFirstLetter(subTitle!),
                  style: AppTextStyle().projectText(fontSize: 9),
                  textAlign: TextAlign.left,
                ),
              ),
              const Expanded(flex: 1, child: horizontalSpaceExtraSmall)
            ],
          ),
        ),
        trailing: SvgPicture.asset(icon!, height: height, width: width),
      ),
    ),
  );
}

//render body design
Stack _renderBody(BuildContext context, AllProjectViewModel viewModel) {
  return Stack(children: [
    //bg image
    Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SvgPicture.asset(
        Images().buildingImg,
        color: black12,
        fit: BoxFit.fill,
      ),
    ),
    if (viewModel.isBusy) ...[
      Container(
          alignment: Alignment.center,
          height: screenHeight(context) * 0.7,
          child: const CircularProgressIndicator(
            color: primaryColor,
          ))
    ] else ...[
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // drag handle
                  Container(
                    height: 3,
                    width: screenWidth(context) / 6,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color: customLightGrey,
                        borderRadius: BorderRadius.circular(1.5)),
                  ),
                  //Project name
                  Text(
                    capitalizeFirstLetter(viewModel
                        .projectDetailResponse['project_name']
                        .toString()),
                    style: Theme.of(context).textTheme.labelLarge,
                    textAlign: TextAlign.center,
                  ),
                  verticalSpaceTiny,
                  if (viewModel.projectDetailResponse['website'] != null) ...[
                    Text(viewModel.projectDetailResponse['website'].toString(),
                        style: AppTextStyle()
                            .resendOtpTextStyle(textColor: FontColor().grey))
                  ],
                  if (viewModel.projectDetailResponse['phone_number'] !=
                      null) ...[
                    Text(
                        'Virtual no: ${viewModel.projectDetailResponse['phone_number']}',
                        style: AppTextStyle()
                            .resendOtpTextStyle(textColor: FontColor().grey))
                  ],
                  verticalSpaceExtraSmall,
                  //users and leads count
                  _renderUserAndLeads(viewModel),
                  verticalSpaceSmall,
                  //address card
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 15),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: greyShade100,
                          blurRadius: 1.0,
                          spreadRadius: 1,
                          offset: Offset(2, 2),
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(Images().projectLocationIcon,
                            height: 38, width: 38),
                        horizontalSpaceExtraSmall,
                        Expanded(
                          child: Text(
                            capitalizeFirstLetter(
                                '${viewModel.projectDetailResponse['address1'] ?? ''}\n${viewModel.projectDetailResponse['address2'] ?? ''}, ${viewModel.projectDetailResponse['address3'] ?? ''}, ${viewModel.projectDetailResponse['city'] ?? ''}, ${viewModel.projectDetailResponse['state'] ?? ''}, ${viewModel.projectDetailResponse['zip'] ?? ''}'),
                            style: AppTextStyle().resendOtpTextStyle(
                                textColor: FontColor().grey),
                            textAlign: TextAlign.start,
                          ),
                        )
                      ],
                    ),
                  ),
                  verticalSpaceSmall,
                  //personal details card
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                            color: greyShade100,
                            blurRadius: 1.0,
                            spreadRadius: 1,
                            offset: Offset(2, 2),
                          )
                        ],
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        minLeadingWidth: 30,
                        leading: SizedBox(
                          height: double.infinity,
                          child: SvgPicture.asset(Images().registrationIcon,
                              height: 34, width: 27),
                        ),
                        title: Text('RERA Registration Number',
                            style: AppTextStyle().mediumSmallText()),
                        subtitle: Text(
                            capitalizeFirstLetter(viewModel
                                .projectDetailResponse['rera_id']
                                .toString()),
                            style: AppTextStyle().buttonTextStyle(borderColor)),
                      )),

                  verticalSpaceSmall,

                  //render tower and floor
                  Row(children: [
                    Expanded(
                        child: _renderCard(context,
                            subTitle: viewModel
                                .projectDetailResponse['number_of_towers']
                                .toString(),
                            height: 42,
                            icon: Images().towersIcon,
                            title: 'Towers',
                            width: 42,
                            onTap: () {})),
                    horizontalSpaceExtraSmall,
                    Expanded(
                        child: _renderCard(context,
                            title: 'Floors',
                            subTitle: viewModel
                                .projectDetailResponse['max_floor']
                                .toString(),
                            icon: Images().stairsIcon,
                            height: 39,
                            width: 39,
                            onTap: () {}))
                  ]),
                  verticalSpaceSmall,
                  //render unit type and sizes
                  Row(children: [
                    Expanded(
                        child: _renderCard(context,
                            subTitle: viewModel
                                .projectDetailResponse['unit_type']
                                .toString(),
                            height: 40,
                            icon: Images().hotelIcon,
                            title: 'Unit Types',
                            width: 40,
                            // isLongSub: true,
                            onTap: () {})),
                    horizontalSpaceExtraSmall,
                    Expanded(
                        child: _renderCard(context,
                            title: 'Unit Size',
                            subTitle:
                                '${viewModel.projectDetailResponse['unit_size'].toString()} sq. ft.',
                            icon: Images().scalailityIcon,
                            height: 32,
                            width: 32,
                            // isLongSub: true,
                            onTap: () {}))
                  ]),
                  verticalSpaceSmall,
                  //render units and documents
                  Row(children: [
                    Expanded(
                        child: _renderCard(context,
                            subTitle: viewModel.projectDetailResponse['units']
                                .toString(),
                            height: 33,
                            icon: Images().hallIcon,
                            title: 'Units',
                            width: 33,
                            onTap: () {})),
                    horizontalSpaceExtraSmall,
                    Expanded(
                        child: _renderCard(context,
                            title: 'Documents',
                            subTitle: document.length.toString(),
                            icon: Images().checkedDocIcon,
                            height: 38,
                            width: 38, onTap: () {
                      viewModel.showProjectDocument();
                    }))
                  ]),
                  verticalSpaceSmall,
                  //render users and leads
                  Row(children: [
                    Expanded(
                        child: _renderCard(context,
                            subTitle: currentTabIndex == 1
                                ? viewModel
                                    .projectDetailResponse['usercount_dst']
                                    .toString()
                                : viewModel
                                    .projectDetailResponse['usercount_cp']
                                    .toString(),
                            height: 27,
                            icon: Images().personYellowIcon,
                            title: 'Users',
                            width: 25,
                            onTap: () {})),
                    horizontalSpaceExtraSmall,
                    Expanded(
                        child: _renderCard(context,
                            title: 'Leads',
                            subTitle: currentTabIndex == 1
                                ? viewModel
                                    .projectDetailResponse['leadcount_dst']
                                    .toString()
                                : viewModel
                                    .projectDetailResponse['leadcount_cp']
                                    .toString(),
                            icon: Images().leadsPersonIcon,
                            height: 31,
                            width: 26,
                            onTap: () {}))
                  ]),
                  verticalSpaceSmall
                ]),
          ),
          if (projectDetailResponseImages.isNotEmpty) ...[
            Container(
              margin: const EdgeInsets.only(left: 15),
              height: 100,
              child: ListView.builder(
                  itemCount: projectDetailResponseImages.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(
                      decelerationRate: ScrollDecelerationRate.normal),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => viewModel.showPreviewDialog(
                          projectDetailResponseImages[index]['url']),
                      child: Container(
                          width: 150,
                          padding: const EdgeInsets.only(right: 10.0),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                  decoration: const BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: black12,
                                          blurRadius: 4.0,
                                          spreadRadius: 0,
                                          offset: Offset(0, 4))
                                    ],
                                  ),
                                  child: Image.network(
                                    projectDetailResponseImages[index]['url'],
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error,
                                            stackTrace) =>
                                        Image.network(
                                            'https://cdn-icons-png.flaticon.com/512/847/847969.png'),
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      return child;
                                    },
                                  )))),
                    );
                  }),
            )
          ],
          verticalSpaceLarge,
          verticalSpaceLarge
        ],
      )
    ],
  ]);
}
