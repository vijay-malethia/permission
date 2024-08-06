import 'package:flutter/material.dart';
import '/ui/common/index.dart';

class DropDown extends StatelessWidget {
  final Function onChanged;
  final String value;
  final List<String> items;
  const DropDown(
      {required this.onChanged,
      required this.items,
      required this.value,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 1, color: borderColor)),
      child: DropdownButton(
        isExpanded: true,
        value: value,
        style: AppTextStyle().inputTextStyle,
        elevation: 0,
        alignment: Alignment.centerLeft,
        underline: const SizedBox(),
        items: items
            .map((String e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(e),
                ))
            .toList(),
        onChanged: (value) {
          onChanged(value);
        },
        iconEnabledColor: FontColor().lightGrey,
      ),
    );
  }
}
