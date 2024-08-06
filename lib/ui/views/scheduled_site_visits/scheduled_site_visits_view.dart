import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sales_lead/ui/common/widgets/table_calendar-3.0.9/lib/table_calendar.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '/ui/common/index.dart';
import '/ui/common/widgets/index.dart';
import 'scheduled_site_visits_viewmodel.dart';
import 'scheduled_site_card.dart';

@FormView(fields: [
  FormTextField(name: 'clientCode'),
  FormTextField(name: 'userCode'),
])
class ScheduledSiteVisitsView
    extends StackedView<ScheduledSiteVisitsViewModel> {
  const ScheduledSiteVisitsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ScheduledSiteVisitsViewModel viewModel,
    Widget? child,
  ) {
    return Stack(
      children: [
        Screen(
          height: screenHeight(context) * 0.15,
          headerChild: _renderHeader(viewModel, context),
          horizontalPadding: 0,
          verticalPadding: 0,
          bodyChild: DraggableBottomSheet(
            minExtent: MediaQuery.of(context).size.height * 0.17,
            useSafeArea: false,
            curve: Curves.easeIn,
            previewWidget: renderWeekTableCalender(viewModel, context),
            expandedWidget: renderWeekTableCalender(viewModel, context,
                format: CalendarFormat.month),
            backgroundWidget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: _backgroundWidget(viewModel, context),
            ),
            maxExtent: MediaQuery.of(context).size.height * 0.55,
            onDragging: (pos) {},
          ),
        ),
        if (viewModel.isBusy) const Loader()
      ],
    );
  }

  Widget _backgroundWidget(
      ScheduledSiteVisitsViewModel viewModel, BuildContext context) {
    return Column(children: [
      Expanded(
        child: Container(
          decoration: const BoxDecoration(
              color: backgroundcolor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Column(children: [
            verticalSpaceSmall,
            if (viewModel.isBusy == false) ...[
              if (viewModel.totalRecord != 0) ...[
                _recordCount(viewModel),
                verticalSpaceSmall,
                Expanded(
                  child: ListView.builder(
                      itemCount: viewModel.scheduleSiteVisitsList.length,
                      shrinkWrap: true,
                      controller: viewModel.scrollController,
                      physics: const ScrollPhysics(),
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (context, index) => index <
                              viewModel.scheduleSiteVisitsList.length
                          ? Column(
                              children: [
                                _renderSlidebleCard(index, viewModel),
                                if (viewModel.scheduleSiteVisitsList.length -
                                        1 ==
                                    index) ...[
                                  verticalSpaceMassive,
                                  verticalSpaceMedium
                                ]
                              ],
                            )
                          : index == viewModel.totalRecord
                              ? const SizedBox()
                              : index == 0
                                  ? const SizedBox()
                                  : const Center(
                                      child: CircularProgressIndicator(
                                          color: primaryColor))),
                ),
              ] else ...[
                SizedBox(
                    height: screenHeight(context) / 2,
                    child: const Center(child: EmptyPlaceHolder())),
              ]
            ]
          ]),
        ),
      ),
    ]);
  }

  @override
  ScheduledSiteVisitsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ScheduledSiteVisitsViewModel()..init();

  // render header
  _renderHeader(ScheduledSiteVisitsViewModel viewModel, BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 15),
        child: InkWell(
          onTap: () => viewModel.goBack(),
          child: Row(children: [
            const Icon(Icons.arrow_back, color: whiteColor),
            horizontalSpaceSmall,
            Text("Scheduled Site Visits",
                style: Theme.of(context).textTheme.displayLarge)
          ]),
        ));
  }

//Total records
  Container _recordCount(ScheduledSiteVisitsViewModel viewModel) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: RichText(
          text: TextSpan(
              text: 'Showing ',
              style: AppTextStyle().smallLarge(fontColor: FontColor().grey),
              children: [
            TextSpan(
              text: viewModel.totalRecord.toString(),
              style: AppTextStyle().smallLarge(fontColor: FontColor().black),
            ),
            TextSpan(
                text: viewModel.totalRecord <= 1 ? ' record' : ' records',
                style: AppTextStyle().smallLarge(fontColor: FontColor().grey))
          ])),
    );
  }

  Container _renderSlidebleCard(
      int index, ScheduledSiteVisitsViewModel viewModel) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: secondaryColor),
      margin: const EdgeInsets.only(bottom: 15),
      child: viewModel.isToday(
                  viewModel.scheduleSiteVisitsList[index]['followup_date']) &&
              viewModel.scheduleSiteVisitsList[index]['is_verified'] != 1
          ? SlidableTile(
              motion: const ScrollMotion(),
              action: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () =>
                          viewModel.showConfirmSiteVisitBottomSheet(index),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              Images().confirmIcon,
                              height: 18,
                              width: 18,
                            ),
                            verticalSpaceTiny,
                            Text(
                              'Confirm',
                              style: AppTextStyle().textheading,
                            )
                          ]),
                    ),
                  ),
                ),
              ],
              valueKey: index,
              child: ScheduledSiteCard(
                personName: capitalizeFirstLetter(
                    viewModel.scheduleSiteVisitsList[index]['lead_name']),
                date: viewModel.formatDate(viewModel
                    .scheduleSiteVisitsList[index]['stage_updated_ts']),
                location: viewModel.scheduleSiteVisitsList[index]
                        ['project_name'][0] ??
                    '',
                companyName: capitalizeFirstLetter(viewModel
                    .scheduleSiteVisitsList[index]['assigned_to_name']),
                clientVistDate: viewModel.formatDate(
                    viewModel.scheduleSiteVisitsList[index]['followup_date']),
                statusBorderColor: Color(int.parse(
                    '0XFF${viewModel.scheduleSiteVisitsList[index]['color_code_2'].toString().split('#').last}')),
                statusColor: Color(int.parse(
                    '0XFF${viewModel.scheduleSiteVisitsList[index]['color_code_1'].toString().split('#').last}')),
                // vistDate: viewModel.scheduleSiteVisitsList[index]
                //         ['dateCreated'] ??
                //     '',
                status: viewModel.scheduleSiteVisitsList[index]['lead_stage'],
                clientVistTime: viewModel.scheduleSiteVisitsList[index]
                        ['followup_time'] ??
                    '',
                isVerified:
                    viewModel.scheduleSiteVisitsList[index]['is_verified'] == 1
                        ? 'Done'
                        : '',
                onTapCall: () {
                  viewModel.showCallDialog(
                      capitalizeFirstLetter(
                          viewModel.scheduleSiteVisitsList[index]['lead_name']),
                      viewModel.scheduleSiteVisitsList[index]['mobile_number']);
                },
                lockIcon:
                    viewModel.scheduleSiteVisitsList[index]['lock_status'] == 1
                        ? true
                        : false,
              ),
            )
          : ScheduledSiteCard(
              personName: capitalizeFirstLetter(
                  viewModel.scheduleSiteVisitsList[index]['lead_name']),
              date: viewModel.formatDate(
                  viewModel.scheduleSiteVisitsList[index]['stage_updated_ts']),
              location: viewModel.scheduleSiteVisitsList[index]['project_name']
                      [0] ??
                  '',
              companyName: viewModel.scheduleSiteVisitsList[index]
                      ['assigned_to_name'] ??
                  '',
              clientVistDate: viewModel.formatDate(
                  viewModel.scheduleSiteVisitsList[index]['followup_date']),
              statusBorderColor: Color(int.parse(
                  '0XFF${viewModel.scheduleSiteVisitsList[index]['color_code_2'].toString().split('#').last}')),
              statusColor: Color(int.parse(
                  '0XFF${viewModel.scheduleSiteVisitsList[index]['color_code_1'].toString().split('#').last}')),
              status:
                  viewModel.scheduleSiteVisitsList[index]['lead_stage'] ?? '',
              clientVistTime: viewModel.scheduleSiteVisitsList[index]
                      ['followup_time'] ??
                  '',
              isVerified:
                  viewModel.scheduleSiteVisitsList[index]['is_verified'] == 1
                      ? 'Done'
                      : '',
              onTapCall: () {
                viewModel.showCallDialog(
                    capitalizeFirstLetter(
                        viewModel.scheduleSiteVisitsList[index]['lead_name']),
                    viewModel.scheduleSiteVisitsList[index]['mobile_number']);
              },
              lockIcon:
                  viewModel.scheduleSiteVisitsList[index]['lock_status'] == 1
                      ? true
                      : false,
            ),
    );
  }

  Widget renderWeekTableCalender(
      ScheduledSiteVisitsViewModel viewModel, BuildContext context,
      {CalendarFormat format = CalendarFormat.week}) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                verticalSpaceExtraSmall,
                Container(
                  height: 3,
                  width: screenWidth(context) / 6,
                  decoration: BoxDecoration(
                      color: calendarNotch,
                      borderRadius: BorderRadius.circular(1.5)),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    // Use SingleChildScrollView to allow scrolling
                    child: TableCalendar(
                      availableGestures: AvailableGestures.all,
                      calendarFormat: format,
                      firstDay: DateTime.now().subtract(
                        const Duration(days: 60),
                      ),
                      calendarBuilders: CalendarBuilders(
                        markerBuilder: (context, day, events) {
                          return viewModel.checkRecord(day)
                              ? Container(
                                  height: 5,
                                  width: 5,
                                  alignment: Alignment.bottomCenter,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ))
                              : Container();
                        },
                      ),
                      lastDay: DateTime.now().add(const Duration(days: 60)),
                      focusedDay: viewModel.selectedDay,
                      onDaySelected: (selectedDay, focusedDay) {
                        viewModel.selectedDayColorsChange(
                            selectedDay, focusedDay);
                      },
                      selectedDayPredicate: (DateTime date) {
                        return isSameDay(viewModel.selectedDay, date);
                      },
                      onHeaderTapped: (focusedDay) {
                        viewModel.selectedDayColorsChange(
                            viewModel.selectedDate, DateTime.now());
                      },
                      onCalendarCreated: (controller) =>
                          viewModel.pageController = controller,
                      calendarStyle: CalendarStyle(
                        outsideDaysVisible: false,
                        isTodayHighlighted: true,
                        selectedDecoration: const BoxDecoration(
                          color: primaryColor,
                          // shape: BoxShape.circle,
                        ),
                        todayTextStyle: AppTextStyle().tableToday,
                        todayDecoration: BoxDecoration(
                            border: const Border.fromBorderSide(
                                BorderSide(color: Colors.white)),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12)),
                        defaultTextStyle: AppTextStyle().tableToday,
                      ),
                      headerVisible: true,
                      daysOfWeekStyle:
                          DaysOfWeekStyle(weekdayStyle: AppTextStyle().table1),
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      weekendDays: const [],
                      weekNumbersVisible: false,
                      headerStyle: HeaderStyle(
                          titleTextFormatter: (date, locale) =>
                              DateFormat('MMM, yyyy', locale).format(date),
                          rightChevronIcon: InkWell(
                              onTap: () {
                                viewModel.selectedDayColorsChange(
                                    DateTime.now(), DateTime.now());
                                viewModel.notifyListeners();
                              },
                              child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text("Today",
                                      style: AppTextStyle().table1))),
                          leftChevronVisible: false,
                          headerPadding: const EdgeInsets.only(left: 10),
                          titleTextStyle: AppTextStyle().tableTitle,
                          formatButtonVisible: false,
                          formatButtonShowsNext: false),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
