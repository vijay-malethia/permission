import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sales_lead/ui/common/widgets/index.dart';
import 'package:sales_lead/ui/views/all_project/all_project_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '/ui/common/index.dart';

class AssignProjectToUserSheet extends StackedView<AllProjectViewModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const AssignProjectToUserSheet({
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: backgroundcolor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const BottomSheetHeader(headerText: 'Assign To'),
          verticalSpaceMedium,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextIconContainer(
                title: 'DST User',
                isSelected: 0 == selectedIndex,
                assetName: Images().userIcon,
                onTap: () {
                  viewModel.onSelect(0, 'Users',
                      projectId: int.parse(request.title!),
                      );
                },
              ),
              horizontalSpaceSmall,
              TextIconContainer(
                title: 'Channel Partner',
                isSelected: 1 == selectedIndex,
                assetName: Images().channelPartnerIcon,
                onTap: () {
                  viewModel.onSelect(1, 'Channel Partner',
                      projectId: int.parse(request.title!),
                       );
                },
              )
            ],
          ),
          verticalSpaceSmall,
        ],
      ),
    );
  }

  @override
  AllProjectViewModel viewModelBuilder(BuildContext context) =>
      AllProjectViewModel();
}

class TextIconContainer extends StatelessWidget {
  final void Function()? onTap;
  final bool isSelected;
  final String title;
  final String assetName;

  const TextIconContainer({
    required this.onTap,
    required this.isSelected,
    required this.title,
    required this.assetName,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(5),
              border:
                  Border.all(color: isSelected ? primaryColor : transparent),
              boxShadow: const [
                BoxShadow(
                    color: lightpink,
                    blurRadius: 10.0,
                    offset: Offset(7.0, 8.0))
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.asset(assetName),
              verticalSpaceSmall,
              Text(capitalizeFirstLetter(title),
                  style: AppTextStyle().buttonTextStyle(FontColor().grey2))
            ],
          ),
        ),
      ),
    );
  }
}
