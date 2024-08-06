import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sales_lead/ui/views/all_project/all_project_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '/ui/common/index.dart';
import '/ui/common/widgets/index.dart';
import '/ui/views/all_project/all_project_viewmodel.dart';

class ProjectDocumentSheet extends StackedView<AllProjectViewModel>
    with $AllProjectView {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const ProjectDocumentSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AllProjectViewModel viewModel,
    Widget? child,
  ) {
    return Container(
      height: 500,
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: const BoxDecoration(
        color: backgroundcolor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BottomSheetHeader(
              imageUrl: Images().checkDocWithBg,
              headerText: 'Project Documents'),
          verticalSpaceSmall,
          verticalSpaceTiny,
          //render prject wiht location
          Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: whiteColor,
                border: Border.all(color: borderColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    Images().buildingIcon,
                    height: 30,
                    width: 25,
                  ),
                  horizontalSpaceTiny,
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          capitalizeFirstLetter((searchController.text.length >
                                      2
                                  ? searchProjectsResponse[currentProjectIndex]
                                      ['project_name']
                                  : (currentTabIndex == 1
                                      ? dstProjectsResponse[currentProjectIndex]
                                          ['project_name']
                                      : cpProjectsResponse[currentProjectIndex]
                                          ['project_name']))
                              .toString()),
                          style: AppTextStyle().personName,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              Images().locationIcon,
                            ),
                            horizontalSpaceTiny,
                            Text(
                              capitalizeFirstLetter(
                                  (searchController.text.length > 2
                                          ? searchProjectsResponse[
                                              currentProjectIndex]['city']
                                          : (currentTabIndex == 1
                                              ? dstProjectsResponse[
                                                  currentProjectIndex]['city']
                                              : cpProjectsResponse[
                                                  currentProjectIndex]['city']))
                                      .toString()),
                              style: AppTextStyle().subTitle,
                            ),
                          ],
                        ),
                        if ((searchController.text.length > 2
                                ? searchProjectsResponse[currentProjectIndex]
                                        ['lastsaledate'] ??
                                    ''
                                : (currentTabIndex == 1
                                    ? dstProjectsResponse[currentProjectIndex]
                                            ['lastsaledate'] ??
                                        ''
                                    : cpProjectsResponse[currentProjectIndex]
                                            ['lastsaledate'] ??
                                        '')) !=
                            '') ...[
                          Row(
                            children: [
                              Text(
                                'Last Sale ',
                                style: AppTextStyle().ninePixel(
                                    fontColor: FontColor().black,
                                    fontFamily: 'nexa-regular'),
                              ),
                              Text(
                                DateFormat('dd-MMM-yyyy').format(DateTime.parse(
                                    (searchController.text.length > 2
                                        ? searchProjectsResponse[
                                            currentProjectIndex]['lastsaledate']
                                        : (currentTabIndex == 1
                                            ? dstProjectsResponse[
                                                    currentProjectIndex]
                                                ['lastsaledate']
                                            : cpProjectsResponse[
                                                    currentProjectIndex]
                                                ['lastsaledate'])))),
                                style: AppTextStyle().ninePixel(
                                    fontColor: FontColor().grey,
                                    fontFamily: 'nexa-regular'),
                              ),
                            ],
                          )
                        ],
                      ]),
                  const Spacer(),
                  Column(
                    children: [
                      CircleAvatar(
                          radius: 22,
                          backgroundColor: lightBgColor,
                          child: Center(
                              child: Text(
                            (searchController.text.length > 2
                                    ? searchProjectsResponse[
                                        currentProjectIndex]['leadscount']
                                    : (currentTabIndex == 1
                                        ? dstProjectsResponse[
                                            currentProjectIndex]['leadscount']
                                        : cpProjectsResponse[
                                            currentProjectIndex]['leadscount']))
                                .toString(),
                            style: AppTextStyle().titletext,
                          ))),
                      Text(
                        'Leads',
                        style: AppTextStyle().textTitleStyle,
                      ),
                    ],
                  ),
                ],
              )),
          verticalSpaceSmall,
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: document.length,
              itemBuilder: (context, index) => _renderProjectDocumentCard(
                  context,
                  title: document[index]['project_collaterals_name'].toString(),
                  subTitle: document[index]['project_collaterals_type_name']
                      .toString(),
                  leadingIcon:
                      document[index]['mime_type_name'] == 'application/pdf'
                          ? Images().pdfIcon
                          : Images().docIcon,
                  storage: viewModel.fileSizeString(
                      bytes: int.parse(document[index]['file_size']),
                      decimals: 2),
                  trailingIcon:
                      document[index]['mime_type_name'] == 'application/pdf'
                          ? Images().pdfIcon
                          : Images().docIcon,
                  height: 31,
                  width: 31,
                  ontap: () => viewModel.showPreviewDialog('Doc',
                      isPdf: true,
                      pdfUrl: document[index]['url'],
                      pdfname: document[index]['project_collaterals_name'])),
            ),
          ),
        ],
      ),
    );
  }

  @override
  AllProjectViewModel viewModelBuilder(BuildContext context) =>
      AllProjectViewModel();
}

//render project details card
Container _renderProjectDocumentCard(BuildContext context,
    {String? title,
    String? subTitle,
    String? storage,
    String? leadingIcon,
    String? trailingIcon,
    double? height,
    double? width,
    GestureTapCallback? ontap}) {
  return Container(
    height: 70,
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 15),
    padding: const EdgeInsets.only(left: 15, right: 15),
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
      onTap: ontap,
      contentPadding: EdgeInsets.zero,
      titleAlignment: ListTileTitleAlignment.center,
      leading: SvgPicture.asset(leadingIcon!,
          height: 36, width: 42, fit: BoxFit.fill),
      title: Text(capitalizeFirstLetter(title!),
          style: AppTextStyle()
              .toastMessageTextStyle(fontColor: FontColor().grey)),
      subtitle: Text(capitalizeFirstLetter(subTitle!),
          style: AppTextStyle().smallLarge(fontColor: borderColor)),
      trailing: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              '$storage',
              style: AppTextStyle().ligthEightPixel(),
              textAlign: TextAlign.center,
            ),
          ),
          horizontalSpaceTiny,
          SvgPicture.asset(
            trailingIcon!,
            height: height,
            width: width,
            fit: BoxFit.cover,
          )
        ],
      ),
    ),
  );
}
