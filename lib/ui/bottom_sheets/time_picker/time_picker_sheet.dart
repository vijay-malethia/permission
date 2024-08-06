import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '/ui/common/index.dart';
import '/ui/common/widgets/buttons.dart';
import 'time_picker_sheet_model.dart';

class TimePickerSheet extends StackedView<TimePickerSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const TimePickerSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TimePickerSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
              height: 200,
              child: CupertinoTimerPicker(
                  initialTimerDuration: Duration(
                      hours: int.parse(request.title!),
                      minutes: int.parse(request.description!)),
                  mode: CupertinoTimerPickerMode.hm,
                  onTimerDurationChanged: (value) =>
                      viewModel.pickTime(value))),
          Row(
            children: [
              Expanded(
                child: Button(
                    onPressed: () {
                      completer!.call(
                          SheetResponse(confirmed: true, data: viewModel.time));
                    },
                    backgroundColor: primaryColor,
                    title: "OK"),
              ),
              horizontalSpaceMedium,
              Expanded(
                child: Button(
                    onPressed: () {
                      completer!.call(SheetResponse(confirmed: false));
                    },
                    backgroundColor: secondaryColor,
                    title: "CANCEL"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  TimePickerSheetModel viewModelBuilder(BuildContext context) =>
      TimePickerSheetModel();
}
