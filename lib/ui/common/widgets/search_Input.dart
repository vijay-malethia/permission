import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

import '../index.dart';

class SearchInput extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final void Function()? onCancel;

  const SearchInput(
      {required this.controller,
      required this.focusNode,
      this.onChanged,
      this.onCancel,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.only(left: 6),
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Material(
              child: InkWell(
                onTap: () {
                  focusNode.requestFocus();
                },
                child: SvgPicture.asset(Images().searchIcon,
                    width: 15, height: 15),
              ),
            ),
          ),
          horizontalSpaceTiny,
          Expanded(
            child: TextFormField(
              focusNode: focusNode,
              controller: controller,
              cursorColor: black54,
              cursorHeight: 20,
              cursorWidth: 1,
              textAlignVertical: TextAlignVertical.center,
              onChanged: onChanged,
              decoration: InputDecoration(
                fillColor: blackColor,
                hintText: 'Search',
                contentPadding: const EdgeInsets.only(bottom: 15),
                hintStyle: AppTextStyle()
                    .toastMessageTextStyle(fontColor: greyShade300),
                border: InputBorder.none,
              ),
              textInputAction: TextInputAction.done,
            ),
          ),
          if (controller.text.isNotEmpty)
            IconButton(
                onPressed: onCancel,
                icon: const Icon(
                  Icons.close,
                  size: 20,
                  color: customGrey,
                ))
        ],
      ),
    );
  }
}
