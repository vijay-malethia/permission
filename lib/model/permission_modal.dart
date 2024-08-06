class PermissionModel {
  final bool? isActive;
  final int? createdBy;
  final int? moduleId;
  final int? permissionId;
  final int? precendentPermissionId;
  final String? createdTimeStamp;
  final String? permissionName;
  final String? permissionDisplayName;
  final String? permissionDescription;
  PermissionModel({
    required this.isActive,
    required this.createdBy,
    required this.moduleId,
    required this.permissionId,
    required this.precendentPermissionId,
    required this.createdTimeStamp,
    required this.permissionName,
    required this.permissionDisplayName,
    required this.permissionDescription,
  });
  factory PermissionModel.fromJson(Map<String, dynamic> json) {
    return PermissionModel(
      isActive: json['is_actives'],
      createdBy: json['createdby'],
      moduleId: json['module_id'],
      permissionId: json['permission_id'],
      precendentPermissionId: json['precedent_permission_id'],
      createdTimeStamp: json['createdts'],
      permissionName: json['permission_name'],
      permissionDisplayName: json['permission_display_name'],
      permissionDescription: json['permission_description'],
    );
  }
}
