class OptionItem {
  final String title;

  OptionItem({required this.title});
  factory OptionItem.fromJson(Map<String, dynamic> json) {
    return OptionItem(title: json['entity_value']);
  }
}
