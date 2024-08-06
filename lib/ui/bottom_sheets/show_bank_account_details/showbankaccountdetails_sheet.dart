import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '/ui/common/index.dart';
import '/ui/common/widgets/index.dart';
import '/ui/views/channel_partner/channel_partner_viewmodel.dart';

class ShowBankAccountDetailsSheet extends StackedView<ChannelPartnerViewModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const ShowBankAccountDetailsSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ChannelPartnerViewModel viewModel,
    Widget? child,
  ) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: const BoxDecoration(
          color: backgroundcolor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          )),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            BottomSheetHeader(
                imageUrl: Images().bankWithBg,
                headerText: 'Bank Account Details'),
            verticalSpaceExtraSmall,
            verticalSpaceTiny,
            //details
            renderDetailsCard()
          ],
        ),
      ),
    );
  }

//render bank details card
  Container renderDetailsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 5),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
        boxShadow: const [
          BoxShadow(
            color: greyShade100,
            blurRadius: 1.0,
            spreadRadius: 1,
            offset: Offset(2, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            visualDensity: const VisualDensity(vertical: -3),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(request.data["account_name"],
                  style: AppTextStyle().buttonTextStyle(FontColor().grey)),
            ),
            subtitle: Text(request.data["account_number"],
                style: AppTextStyle().buttonTextStyle(borderColor)),
            trailing:
                SvgPicture.asset(Images().passbookIcon, height: 28, width: 44),
          ),
          Text(request.data["bank_name"],
              textAlign: TextAlign.start,
              style: AppTextStyle().smallText(fontColor: FontColor().grey)),
          Align(
            alignment: Alignment.topRight,
            child: Text('IFSC : ${request.data["ifsc_code"]}',
                textAlign: TextAlign.start,
                style: AppTextStyle().smallText(fontColor: customGrey)),
          )
        ],
      ),
    );
  }

  @override
  ChannelPartnerViewModel viewModelBuilder(BuildContext context) =>
      ChannelPartnerViewModel();
}
