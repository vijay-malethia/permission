import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sales_lead/ui/common/widgets/index.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '/ui/common/index.dart';
import '/ui/views/incoming_call/incoming_call_view.form.dart';
import '/ui/views/incoming_call/incoming_call_viewmodel.dart';

class FilterBySheet extends StackedView<IncomingCallViewModel>
    with $IncomingCallView {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const FilterBySheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    IncomingCallViewModel viewModel,
    Widget? child,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const BottomSheetHeader(
                headerText: 'Filter By', closeIconPadding: 0),
            verticalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Status",
                  style: AppTextStyle().inputLabelTextStyle(),
                ),
              ],
            ),
            verticalSpaceExtraSmall,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: Button(
                  onPressed: () {
                    viewModel.selectButton('Answered');
                  },
                  title: "Answered",
                  backgroundColor: whiteColor,
                  borderColor: selectedButton == 'Answered'
                      ? primaryColor
                      : borderColor,
                  textColor:selectedButton == 'Answered'
                      ? primaryColor
                      : greyDark,
                )),
                const SizedBox(width: 30),
                Expanded(
                    child: Button(
                  onPressed: () {
                    viewModel.selectButton('Missed');
                  },
                  title: "Missed",
                  backgroundColor: whiteColor,
                  borderColor: selectedButton == 'Missed'
                      ? primaryColor
                      : borderColor,
                  textColor: selectedButton == 'Missed'
                      ? primaryColor
                      : greyDark,
                ))
              ],
            ),
            verticalSpaceMedium,
            Text(
              'Date',
              style: AppTextStyle().inputLabelTextStyle(),
            ),
            verticalSpaceExtraSmall,
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      viewModel.setSelectingType(true);
                      viewModel.showDatePickerBottomSheet();
                    },
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: borderColor),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            fromDate.isNotEmpty ? fromDate : "From",
                            style: fromDate.isNotEmpty
                                ? AppTextStyle().inputTextStyle
                                : AppTextStyle()
                                    .buttonTextStyle(FontColor().lightGrey),
                          ),
                          SvgPicture.asset(
                            Images().calenderMonth,
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                horizontalSpaceMedium,
                Expanded(
                  child: InkWell(
                    onTap: () {
                      viewModel.setSelectingType(false);
                      viewModel.showDatePickerBottomSheet();
                    },
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: borderColor),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            toDate.isNotEmpty ? toDate : "To",
                            style: toDate.isNotEmpty
                                ? AppTextStyle().inputTextStyle
                                : AppTextStyle()
                                    .buttonTextStyle(FontColor().lightGrey),
                          ),
                          SvgPicture.asset(
                            Images().calenderMonth,
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            verticalSpaceMedium,
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    completer!.call(SheetResponse(confirmed: false));
                  
                  },
                  child: Text("Clear Filter",
                      style: AppTextStyle().buttonTextStyle(FontColor().brown)),
                ),
                const SizedBox(width: 50),
                Expanded(
                    child: Button(
                        onPressed: () {
                          completer!.call(SheetResponse(confirmed: true));
                        },
                        title: "SHOW RESULT")),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  IncomingCallViewModel viewModelBuilder(BuildContext context) =>
      IncomingCallViewModel();
}
