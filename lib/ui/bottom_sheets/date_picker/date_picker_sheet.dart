import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '/ui/common/index.dart';
import '/ui/common/widgets/index.dart';
import '/ui/views/incoming_call/incoming_call_viewmodel.dart';
import 'date_picker_sheet_model.dart';

class DatePickerSheet extends StackedView<DatePickerSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const DatePickerSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    DatePickerSheetModel viewModel,
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
            child: CupertinoDatePicker(
              minimumDate: request.description != null ? DateTime.now() : null,
              initialDateTime: request.description != null
                  ? null
                  : request.title!.isNotEmpty
                      ? DateTime.parse(request.title!)
                      : fromDate.isEmpty || toDate.isEmpty
                          ? DateTime.now()
                          : (isSelectingFromDate
                              ? DateTime.parse(fromDate)
                              : DateTime.parse(toDate)),
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime newDate) async {
                if (isSelectingFromDate) {
                  fromDate = DateFormat('yyyy-MM-dd').format(newDate);
                  viewModel.notifyListeners();
                } else {
                  toDate = DateFormat('yyyy-MM-dd').format(newDate);
                  viewModel.notifyListeners();
                }
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Button(
                    onPressed: () {
                      if (isSelectingFromDate) {
                        if (fromDate == '' && toDate.isEmpty) {
                          fromDate =
                              DateFormat('yyyy-MM-dd').format(DateTime.now());
                          viewModel.notifyListeners();
                        } else if (fromDate == '') {
                          fromDate = '';
                          showCustomToast(
                              context,
                              'From date should not be greator then To date ',
                              '');
                        } else if (toDate.isNotEmpty) {
                          if ((DateTime.parse(fromDate))
                                  .isAfter(DateTime.parse(toDate)) ||
                              (DateTime.parse(toDate))
                                  .isAtSameMomentAs(DateTime.parse(fromDate))) {
                            fromDate = '';
                            showCustomToast(
                                context,
                                'From date should not be greator then To date ',
                                '');
                          }
                        }
                      } else {
                        if (toDate == '' && fromDate.isEmpty) {
                          toDate =
                              DateFormat('yyyy-MM-dd').format(DateTime.now());
                          viewModel.notifyListeners();
                        } else if (toDate == '' &&
                            fromDate ==
                                DateFormat('yyyy-MM-dd')
                                    .format(DateTime.now())) {
                          toDate = '';
                          showCustomToast(
                              context,
                              'From date should not be greator then To date ',
                              '');
                        } else if (toDate == '' &&
                            !DateTime.parse(fromDate)
                                .isAtSameMomentAs(DateTime.now())) {
                          toDate =
                              DateFormat('yyyy-MM-dd').format(DateTime.now());
                        } else if (fromDate.isNotEmpty) {
                          if ((DateTime.parse(toDate))
                                  .isBefore(DateTime.parse(fromDate)) ||
                              (DateTime.parse(fromDate))
                                  .isAtSameMomentAs(DateTime.parse(toDate))) {
                            toDate = '';
                            showCustomToast(
                                context,
                                'From date should not be greator then To date ',
                                '');
                          }
                        }
                      }

                      completer!
                          .call(SheetResponse(confirmed: true, data: fromDate));
                    },
                    backgroundColor: primaryColor,
                    title: "OK"),
              ),
              horizontalSpaceMedium,
              Expanded(
                child: Button(
                    onPressed: () {
                      completer!.call(SheetResponse(confirmed: true));
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
  DatePickerSheetModel viewModelBuilder(BuildContext context) =>
      DatePickerSheetModel();
}
