import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/ui/common/index.dart';

class Input extends StatelessWidget {
  final FocusNode focusNode;

  final TextEditingController controller;

  const Input({required this.controller, required this.focusNode, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenDimension(context) / 24,
      padding: const EdgeInsets.only(left: 6),
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(10)),
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
              cursorHeight: 18,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                fillColor: blackColor,
                hintText: 'Search',
                contentPadding: const EdgeInsets.only(bottom: 15),
                hintStyle: AppTextStyle().buttonTextStyle(
                  greyShade300,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                controller.clear();

                focusNode.unfocus();
              },
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
