import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '/ui/common/index.dart';
import '/ui/views/all_project/all_project_viewmodel.dart';
import '/ui/views/primary_person_detail/registration_viewmodel.dart';

class ImgePreviewDialog extends StackedView<RegistrationViewModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const ImgePreviewDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    RegistrationViewModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      alignment: Alignment.bottomCenter,
      insetPadding: const EdgeInsets.symmetric(horizontal: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: request.data != null && request.data.runtimeType == List
          ? blackColor
          : backgroundcolor,
      child: SizedBox(
        height: screenHeight(context) - MediaQuery.of(context).viewPadding.top,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: request.hasImage != null && request.hasImage == true
              ? [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () =>
                                completer(DialogResponse(confirmed: true)),
                            child: const Icon(
                              Icons.arrow_back,
                              color: whiteColor,
                            )),
                        horizontalSpaceSmall,
                        Text(
                          request.description.toString(),
                          style: AppTextStyle()
                              .sixteenPixel(textColor: whiteColor),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: SfPdfViewer.network(
                      request.title.toString(),
                      key: AllProjectViewModel().pdfViewerKey,
                    ),
                  )
                ]
              : [
                  request.data != null && request.data.runtimeType == List
                      ? Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              InkWell(
                                  onTap: () => completer(
                                      DialogResponse(confirmed: true)),
                                  child: const Icon(
                                    Icons.arrow_back,
                                    color: whiteColor,
                                  )),
                              horizontalSpaceSmall,
                              Text(
                                request.data[viewModel.pageViewImageIndex]
                                    ['project_collaterals_name'],
                                style: AppTextStyle()
                                    .sixteenPixel(textColor: whiteColor),
                              )
                            ],
                          ),
                        )
                      : Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: InkWell(
                                onTap: () =>
                                    completer(DialogResponse(confirmed: true)),
                                child: const Icon(Icons.close)),
                          )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: SizedBox(
                      height: screenHeight(context) -
                          MediaQuery.of(context).viewPadding.top -
                          100,
                      child: request.data != null &&
                              request.data.runtimeType != List
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child:
                                  Image.file(request.data, fit: BoxFit.contain))
                          : request.data != null &&
                                  request.data.runtimeType == List
                              ? PageView(
                                  onPageChanged: (value) {
                                    viewModel.pageViewImageIndex = value;
                                    viewModel.notifyListeners();
                                  },
                                  scrollDirection: Axis.horizontal,
                                  children: (request.data as List)
                                      .map((e) => ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            e['url'],
                                            fit: BoxFit.contain,
                                            errorBuilder: (context, error,
                                                    stackTrace) =>
                                                Image.network(
                                                    'https://cdn-icons-png.flaticon.com/512/847/847969.png'),
                                          )))
                                      .toList())
                              : Center(
                                  child: Text('No Image Available',
                                      style: AppTextStyle().inputTextStyle)),
                    ),
                  )
                ],
        ),
      ),
    );
  }

  @override
  RegistrationViewModel viewModelBuilder(BuildContext context) =>
      RegistrationViewModel();
}
