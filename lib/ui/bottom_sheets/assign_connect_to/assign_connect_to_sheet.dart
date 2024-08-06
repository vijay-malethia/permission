import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/ui/common/widgets/index.dart';
import '/ui/common/index.dart';
import 'assign_connect_to_sheet_model.dart';

class AssignConnectToSheet extends StackedView<AssignConnectToSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const AssignConnectToSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AssignConnectToSheetModel viewModel,
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
          const BottomSheetHeader(headerText: 'Connect as'),
          verticalSpaceMedium,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextIconContainer(
                title: 'Existing Customer',
                isSelected: 0 == viewModel.selectedIndex,
                assetName: Images().userIcon,
                onTap: () {
                  // viewModel.onSelect(0, 'Existing Customer');
                },
              ),
              horizontalSpaceSmall,
              TextIconContainer(
                title: 'Channel Partner',
                isSelected: 1 == viewModel.selectedIndex,
                assetName: Images().channelPartnerIcon,
                onTap: () {
                  viewModel.onSelect(1, 'Channel Partner');
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
  AssignConnectToSheetModel viewModelBuilder(BuildContext context) =>
      AssignConnectToSheetModel();
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
              Text(title,
                  style: AppTextStyle().buttonTextStyle(FontColor().grey2))
            ],
          ),
        ),
      ),
    );
  }
}
