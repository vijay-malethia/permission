class AllProjectModel {
  String location;
  String lastSale;
  String city;
  List<dynamic> cpList;
  List<dynamic> cpUsers;
  List<dynamic> managers;
  int projectId;
  int leadCount;
  int userCount;

  AllProjectModel({
    required this.leadCount,
    required this.projectId,
    required this.userCount,
    required this.location,
    required this.cpList,
    required this.cpUsers,
    required this.managers,
    required this.lastSale,
    required this.city,
  });
}
