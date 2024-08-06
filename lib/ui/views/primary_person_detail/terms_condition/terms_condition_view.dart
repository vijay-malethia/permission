import 'package:flutter/material.dart';
import 'package:sales_lead/ui/common/index.dart';
import 'package:sales_lead/ui/common/widgets/index.dart';
import 'package:sales_lead/ui/views/primary_person_detail/registration_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsConditionView extends StackedView<RegistrationViewModel> {
  final String? headerTitle;
  const TermsConditionView(this.headerTitle, {Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    RegistrationViewModel viewModel,
    Widget? child,
  ) {
    return Stack(
      children: [
        Screen(
          height: screenHeight(context) * 0.12,
          headerChild: _renderHeader(viewModel, context, headerTitle!),
          bodyChild: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: WebViewWidget(controller: viewModel.termsController))
            ],
          ),
        ),
        if (viewModel.isDataLoading) const Loader()
      ],
    );
  }

  @override
  RegistrationViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RegistrationViewModel()..getTermsAndConditons();

//Header
  _renderHeader(
      RegistrationViewModel viewModel, BuildContext context, String title) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: InkWell(
          onTap: viewModel.goBack,
          child: Row(children: [
            const Icon(Icons.arrow_back, color: whiteColor),
            horizontalSpaceTiny,
            Text(title, style: Theme.of(context).textTheme.displayLarge)
          ]),
        ));
  }
}
