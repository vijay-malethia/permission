class ListResponse<T> {
  final List<T> data;

  ListResponse({required this.data});

  factory ListResponse.fromJson(
      List<dynamic> json, T Function(Map<String, dynamic>) buildItem) {
    return ListResponse<T>(
      data: (json)
          .map(
            (item) => buildItem(item),
          )
          .toList(),
    );
  }
}
