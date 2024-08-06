import 'package:flutter/material.dart';

import 'package:sales_lead/model/dropdown_item_model.dart';
import '../index.dart';

class SelectDropList extends StatefulWidget {
  final OptionItem itemSelected;
  final List<OptionItem> dropListModel;
  final bool isReadOnly;
  final Function(OptionItem optionItem) onOptionSelected;
  final ScrollController? scrollController;

  final String? labelText;
  final bool isRequired;

  const SelectDropList(
    this.itemSelected,
    this.dropListModel,
    this.onOptionSelected, {
    this.labelText,
    this.isReadOnly = false,
    super.key,
    this.scrollController,
    this.isRequired = true,
  });

  @override
  SelectDropListState createState() => SelectDropListState();
}

class SelectDropListState extends State<SelectDropList>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  bool isShow = false;

  SelectDropListState();

  @override
  void initState() {
    super.initState();
    expandController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    _runExpandCheck();
  }

  void _runExpandCheck() async {
    if (isShow) {
      await expandController.forward();

      widget.scrollController == null
          ? () {}
          : widget.scrollController!.animateTo(
              widget.scrollController!.position.maxScrollExtent,
              curve: Curves.fastOutSlowIn,
              duration: const Duration(seconds: 1),
            );
    } else {
      expandController.reverse();
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.labelText != null) ...[
              Text(
                widget.labelText!,
                style: AppTextStyle().inputLabelTextStyle(),
              ),
              verticalSpaceExtraSmall,
            ],
            Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: whiteColor,
                  border: Border.all(color: borderColor, width: 1),
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: widget.isReadOnly
                        ? null
                        : () {
                            isShow = !isShow;
                            _runExpandCheck();

                            setState(() {});
                          },
                    child: Container(
                      height: 45,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          color: whiteColor,
                          border: const Border.fromBorderSide(BorderSide(
                              strokeAlign: 1, color: borderColor, width: 1)),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            widget.itemSelected.title,
                            style: AppTextStyle().inputTextStyle,
                          ),
                          Expanded(child: Container()),
                          Icon(
                            isShow
                                ? Icons.arrow_drop_up_rounded
                                : Icons.arrow_drop_down_rounded,
                            color: FontColor().lightGrey,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizeTransition(
                      axisAlignment: 1.0,
                      sizeFactor: animation,
                      child: Container(
                          height: widget.dropListModel.length > 6 ? 190 : null,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 2),
                          alignment: Alignment.centerLeft,
                          child: _buildDropListOptions(
                              widget.dropListModel, context))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView _buildDropListOptions(List<OptionItem> items, BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      children: items.map((item) => _buildSubMenu(item, context)).toList(),
    );
  }

  Widget _buildSubMenu(OptionItem item, BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        margin: const EdgeInsets.all(2),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: backgroundcolor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(item.title,
            style: AppTextStyle().tncTextStyle(),
            maxLines: 3,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis),
      ),
      onTap: () {
        setState(() {
          isShow = false;
        });
        expandController.reverse();
        widget.onOptionSelected(item);
      },
    );
  }
}
