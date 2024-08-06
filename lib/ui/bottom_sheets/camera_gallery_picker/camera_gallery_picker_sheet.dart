import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sales_lead/ui/common/index.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'camera_gallery_picker_sheet_model.dart';

class CameraGalleryPickerSheet
    extends StackedView<CameraGalleryPickerSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const CameraGalleryPickerSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CameraGalleryPickerSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    completer!.call(SheetResponse(
                        confirmed: true, data: ImageSource.gallery));
                  },
                  child: Text("Photo Gallery",
                      style: AppTextStyle()
                          .signHeaderStyle(textColor: blueShade300)),
                ),
                const Divider(color: black26),
                InkWell(
                  onTap: () {
                    completer!.call(SheetResponse(
                        confirmed: true, data: ImageSource.camera));
                  },
                  child: Text("Camera",
                      style: AppTextStyle()
                          .signHeaderStyle(textColor: blueShade300)),
                ),
              ],
            ),
          ),
          verticalSpaceSmall,
          InkWell(
            onTap: () {
              completer!.call(SheetResponse(confirmed: false));
            },
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                alignment: Alignment.center,
                child: Text("Cancel",
                    style: AppTextStyle().signHeaderStyle(
                        textColor: const Color.fromARGB(255, 33, 89, 243)))),
          )
        ],
      ),
    );
  }

  @override
  CameraGalleryPickerSheetModel viewModelBuilder(BuildContext context) =>
      CameraGalleryPickerSheetModel();
}
