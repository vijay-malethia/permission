import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '/ui/views/all_project/all_project_view.dart';
import '/ui/views/channel_partner/channel_partner_view.dart';
import '/ui/views/lead/all_leads/all_leads_view.dart';
import '/ui/views/allusers/allusers_view.dart';
import '/ui/views/incoming_call/incoming_call_view.dart';
import '/ui/views/home/floating_action_menu.dart';
import '/ui/views/home/home.dart';
import '/ui/common/widgets/index.dart';
import '/ui/common/index.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  final int pageIndex;
  const HomeView({required this.pageIndex, Key? key}) : super(key: key);
  getViewForIndex(int index, HomeViewModel viewModel) {
    switch (index) {
      case 0:
        return const Home();
      case 1:
        return const AllusersView();
      case 2:
        return const AllLeadsView();
      case 3:
        return const IncomingCallView();
      case 4:
        return const AllProjectView();
      case 5:
        return const ChannelPartnerView();
      default:
        return const Home();
    }
  }

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return WillPopScope(
      onWillPop: () async {
        currentIndex != 0 ? viewModel.goBack() : SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: const BottomBar(),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  decoration: const BoxDecoration(
                      gradient: RadialGradient(
                          tileMode: TileMode.decal,
                          radius: 12,
                          center: Alignment.topCenter,
                          colors: [
                            transparent,
                            black54,
                          ]),
                      shape: BoxShape.circle),
                  child: FloatingActionButton(
                      backgroundColor: transparent,
                      elevation: 0,
                      onPressed: viewModel.openFloatingAction,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: const [
                              BoxShadow(
                                  color: blackTransparent,
                                  blurRadius: 4,
                                  offset: Offset(0, 4))
                            ]),
                        height: screenDimension(context) / 25.9,
                        width: screenDimension(context) / 25.9,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  floatingActionGradient1,
                                  floatingActionGradient2
                                ]),
                          ),
                          child: Transform.rotate(
                            angle: viewModel.isActionOPen ? 0 : 0.8,
                            child: const Icon(
                              Icons.clear_rounded,
                              size: 25,
                            ),
                          ),
                        ),
                      ))),
              SizedBox(height: screenDimension(context) / 80)
            ],
          ),
          body: InkWell(
            onTap: viewModel.isActionOPen ? viewModel.openFloatingAction : null,
            child: Stack(children: [
              getViewForIndex(pageIndex, viewModel),
              if (viewModel.isActionOPen) ...[
                FloatingActionMenu(
                  onChannelPartnerTap: () {
                    viewModel.navigateToDstCP();
                  },
                  onCaptureLeadTap: () {
                    viewModel.navigateToCaptureLeadView();
                  },
                )
              ]
            ]),
          )),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
