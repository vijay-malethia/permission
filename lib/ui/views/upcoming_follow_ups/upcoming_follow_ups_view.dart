import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sales_lead/ui/common/widgets/table_calendar-3.0.9/lib/table_calendar.dart';
import 'package:stacked/stacked.dart';

import '/ui/common/widgets/empty_placeholder.dart';
import '/ui/common/widgets/screen.dart';
import '/ui/common/widgets/slidable_tile.dart';
import '../../common/index.dart';
import 'upcoming_follow_ups_viewmodel.dart';
import '/ui/views/upcoming_follow_ups/upcoming_follow_up_card.dart';

class UpcomingFollowUpsView extends StackedView<UpcomingFollowUpsViewModel> {
  const UpcomingFollowUpsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    UpcomingFollowUpsViewModel viewModel,
    Widget? child,
  ) {
    return Stack(
      children: [
        Screen(
          height: screenHeight(context) * 0.15,
          headerChild: renderHeader(viewModel, context),
          horizontalPadding: 0,
          verticalPadding: 0,
          bodyChild: DraggableBottomSheet(
            minExtent: MediaQuery.of(context).size.height * 0.16,
            useSafeArea: false,
            curve: Curves.easeIn,
            previewWidget: renderTableCalender(viewModel, context),
            expandedWidget: renderTableCalender(viewModel, context,
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
      UpcomingFollowUpsViewModel viewModel, BuildContext context) {
    return Column(children: [
      Expanded(
        child: Container(
          decoration: const BoxDecoration(
              color: backgroundcolor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Column(children: [
            renderSelectBar(viewModel), //Select Bar
            verticalSpaceSmall,
            if (viewModel.isBusy == false) ...[
              if (viewModel.totalRecord != 0) ...[
                _recordCount(viewModel),
                verticalSpaceSmall,
                Expanded(
                  child: ListView.builder(
                      itemCount: viewModel.upcomingFollowUpsLsit.length,
                      shrinkWrap: true,
                      controller: viewModel.scrollController,
                      physics: const ScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 120),
                      itemBuilder: (context, index) =>
                          index < viewModel.upcomingFollowUpsLsit.length
                              ? Column(
                                  children: [
                                    _renderSlidebleCard(index, viewModel),
                                    if (viewModel.upcomingFollowUpsLsit.length -
                                            1 ==
                                        index)
                                      verticalSpaceLarge
                                  ],
                                )
                              : index == viewModel.totalRecord
                                  ? const SizedBox()
                                  : index == 0
                                      ? const SizedBox()
                                      : const Center(
                                          child: CircularProgressIndicator(
                                              color: primaryColor))),
                )
              ],
              if (viewModel.totalRecord == 0)
                SizedBox(
                    height: screenHeight(context) / 2,
                    child: const EmptyPlaceHolder()),
            ]
          ]),
        ),
      ),
    ]);
  }

//Records row
  Container _recordCount(UpcomingFollowUpsViewModel viewModel) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: RichText(
          text: TextSpan(
              text: 'Showing ',
              style: AppTextStyle().tncTextStyle(),
              children: [
            TextSpan(
                text: viewModel.totalRecord.toString(),
                style: AppTextStyle()
                    .textButtonTextStyle(textColor: FontColor().blue1)),
            TextSpan(
                text: viewModel.totalRecord <= 1 ? ' record' : ' records',
                style: AppTextStyle().tncTextStyle())
          ])),
    );
  }

  Container _renderSlidebleCard(
      int index, UpcomingFollowUpsViewModel viewModel) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: secondaryColor),
      margin: const EdgeInsets.only(bottom: 15),
      child: SlidableTile(
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
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      Images().update,
                      height: 18,
                      width: 18,
                    ),
                    verticalSpaceTiny,
                    Text(
                      'Update',
                      style: AppTextStyle().textheading,
                    )
                  ]),
            ),
          ),
        ],
        valueKey: index,
        child: UpcomingFollowUpCard(
          companyName: capitalizeFirstLetter(
              viewModel.upcomingFollowUpsLsit[index]['assigned_to_name']),
          date: viewModel.formatDate(
              viewModel.upcomingFollowUpsLsit[index]['stage_updated_ts']),
          location: viewModel.upcomingFollowUpsLsit[index]['project_name'][0],
          personName: capitalizeFirstLetter(
              viewModel.upcomingFollowUpsLsit[index]['lead_name'] ?? ''),
          clientVistDate: viewModel.formatDate(
              viewModel.upcomingFollowUpsLsit[index]['followup_date']),
          statusBorderColor: Color(int.parse(
              '0XFF${viewModel.upcomingFollowUpsLsit[index]['color_code_2'].toString().split('#').last}')),
          statusColor: Color(int.parse(
              '0XFF${viewModel.upcomingFollowUpsLsit[index]['color_code_1'].toString().split('#').last}')),
          // vistDate:viewModel.upcomingFollowUpsLsit[index]['lead_name'],
          status: viewModel.upcomingFollowUpsLsit[index]['lead_stage'] ?? '',
          clientVistTime: viewModel.upcomingFollowUpsLsit[index]
              ['followup_time'],
          // trailingIconName: viewModel.upcomingFollowUpsLsit[index]
          //     ['followup_outcome'],
          followUpType: viewModel.upcomingFollowUpsLsit[index]
                  ['followup_type_name'] ??
              '',
          onTapCall: () {
            viewModel.showCallDialog(
                capitalizeFirstLetter(
                    viewModel.upcomingFollowUpsLsit[index]['lead_name'] ?? ''),
                viewModel.upcomingFollowUpsLsit[index]['mobile_number']);
          },
          onTapCloudCall: () {
            viewModel.showCloudCall(
                capitalizeFirstLetter(
                    viewModel.upcomingFollowUpsLsit[index]['lead_name'] ?? ''),
                viewModel.upcomingFollowUpsLsit[index]['mobile_number'],
                viewModel.upcomingFollowUpsLsit[index]['lead_id'],
                viewModel.upcomingFollowUpsLsit[index]['followup_id']);
          },
          onTapEmail: () {
            viewModel.sendMail(emailId: 'test@gmail.com');
          },
          // onFollowUpTap: () => viewModel.goToFollowUpScreen(index),
        ),
      ),
    );
  }

  // render header
  renderHeader(UpcomingFollowUpsViewModel viewModel, BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 15),
        child: InkWell(
          onTap: () => viewModel.goBack(context),
          child: Row(children: [
            const Icon(Icons.arrow_back, color: whiteColor),
            horizontalSpaceSmall,
            Text("Upcoming Follow ups",
                style: Theme.of(context).textTheme.displayLarge)
          ]),
        ));
  }

//Render Select Bar
  Widget renderSelectBar(UpcomingFollowUpsViewModel viewModel) {
    return Container(
      height: 30,
      decoration:
          BoxDecoration(color: tabBg, borderRadius: BorderRadius.circular(25)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              viewModel.selectTab('All');
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: viewModel.selectedTab == 'All' ? orange : transparent,
                  borderRadius: BorderRadius.circular(25)),
              child: Text('All',
                  style: AppTextStyle().selectBar(
                    viewModel.selectedTab == 'All' ? whiteColor : blackColor,
                  )),
            ),
          ),
          GestureDetector(
            onTap: () {
              viewModel.selectTab('Call');
            },
            child: Container(
              alignment: Alignment.center,
              height: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: viewModel.selectedTab == 'Call' ? orange : transparent,
                  borderRadius: BorderRadius.circular(25)),
              child: Text('Call',
                  style: AppTextStyle().selectBar(
                    viewModel.selectedTab == 'Call' ? whiteColor : blackColor,
                  )),
            ),
          ),
          GestureDetector(
            onTap: () {
              viewModel.selectTab('Email');
            },
            child: Container(
              alignment: Alignment.center,
              height: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color:
                      viewModel.selectedTab == 'Email' ? orange : transparent,
                  borderRadius: BorderRadius.circular(25)),
              child: Text('Email',
                  style: AppTextStyle().selectBar(
                    viewModel.selectedTab == 'Email' ? whiteColor : blackColor,
                  )),
            ),
          ),
          GestureDetector(
            onTap: () {
              viewModel.selectTab('Site Visit');
            },
            child: Container(
              alignment: Alignment.center,
              height: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  color: viewModel.selectedTab == 'Site Visit'
                      ? orange
                      : transparent,
                  borderRadius: BorderRadius.circular(25)),
              child: Text('Site Visit',
                  style: AppTextStyle().selectBar(
                    viewModel.selectedTab == 'Site Visit'
                        ? whiteColor
                        : blackColor,
                  )),
            ),
          ),
          GestureDetector(
            onTap: () {
              viewModel.selectTab('Client Visit');
            },
            child: Container(
              alignment: Alignment.center,
              height: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: viewModel.selectedTab == 'Client Visit'
                      ? orange
                      : transparent,
                  borderRadius: BorderRadius.circular(25)),
              child: Text('Client Visit',
                  style: AppTextStyle().selectBar(
                    viewModel.selectedTab == 'Client Visit'
                        ? whiteColor
                        : blackColor,
                  )),
            ),
          )
        ],
      ),
    );
  }

  Widget renderTableCalender(
      UpcomingFollowUpsViewModel viewModel, BuildContext context,
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
                      color: borderColor,
                      borderRadius: BorderRadius.circular(1.5)),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: TableCalendar(
                      // onPageChanged: (focusedDay)  {
                      //     viewModel.getUpcomingFollowUpsCount(DateFormat("MM-yyyy").format(focusedDay).toString());
                      // },
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
                      pageAnimationEnabled: false,
                      availableGestures: AvailableGestures.all,
                      rowHeight: 45,
                      calendarFormat: format,
                      firstDay: DateTime.now().subtract(
                        const Duration(days: 60),
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
                      onCalendarCreated: (controller) =>
                          viewModel.pageController = controller,
                      calendarStyle: CalendarStyle(
                        outsideDaysVisible: false,
                        isTodayHighlighted: true,
                        holidayDecoration:
                            const BoxDecoration(color: blackColor),
                        selectedDecoration: BoxDecoration(
                            color: FontColor().red,
                            shape: BoxShape.rectangle,
                            boxShadow: const [
                              BoxShadow(
                                color: greyShade600,
                                blurRadius: 3.0,
                                offset: Offset(0.0, 3),
                              )
                            ]),
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
                          },
                          child: Text("Today", style: AppTextStyle().table1),
                        ),
                        leftChevronVisible: false,
                        headerPadding: const EdgeInsets.only(left: 10),
                        titleTextStyle: AppTextStyle().tableTitle,
                        formatButtonVisible: false,
                      ),
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

  @override
  UpcomingFollowUpsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      UpcomingFollowUpsViewModel()..init();
}
