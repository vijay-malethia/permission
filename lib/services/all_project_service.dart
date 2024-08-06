import 'package:dio/dio.dart';
import 'package:sales_lead/api/endpoints.dart';
import 'package:sales_lead/api/http_request.dart';

class AllProjectService {
  //Get Project details of individual project
  Future<Response> getProjectDetail(int projectId) {
    return httpRequest
        .get('${Endpoints.getProjectDetailById}?project_id=$projectId');
  }

  // Get all projects to assign users/cp
  Future<Response> getProjectsListToAssign({
    String? search,
    required int? pageNo,
    required int? userTypeId,
    int? cpId,
  }) async {
    return httpRequest.get(
        '${Endpoints.getAllProjectsToAssign}?user_type_id=$userTypeId&page_no=$pageNo${search == null ? '' : '&search=$search'}${cpId == null ? '' : '&cp_id=$cpId'}');
  }
  //Get Project List assigned to current loged in user
  Future<Response> getMyProjectsList() async {
    return httpRequest.get(Endpoints.getMyProjects);
  }

  // Get unassigned user who don't have current project assigned
  Future<Response> getUnassignedUsersByProjectId({
    int? projectId,
  }) async {
    return httpRequest.get(
        '${Endpoints.getUnassignedUsersByProjectId}?project_id=$projectId');
  }

  // Get assigned users who have been assigned to current project
  Future<Response> getAssignedUsersByProjectId({
    int? projectId,
  }) async {
    return httpRequest
        .get('${Endpoints.getAssignedUsersByProjectId}?project_id=$projectId');
  }

  // Get assigned CP who don't have current project assigned
  Future<Response> getUnassignedCPByProjectId({
    int? projectId,
  }) async {
    return httpRequest
        .get('${Endpoints.getUnassignedCPByProjectId}?project_id=$projectId');
  }

  // Get assigned CP who have been assigned to current project
  Future<Response> getAssignedCPByProjectId({
    int? projectId,
  }) async {
    return httpRequest
        .get('${Endpoints.getAssignedCpByProjectId}?project_id=$projectId');
  }

  // Assign project to respective user
  Future<Response> assignProjectToUser({
    int? projectId,
    int? userId,
    int? permissionID,
  }) async {
    return httpRequest.put(
        '${Endpoints.assignProjectToUser}?project_id=$projectId&assign_to_user_id=$userId&permission_id=$permissionID');
  }

  // Remove user from respective project
  Future<Response> removeProjectFromUser({
    int? projectId,
    int? currentUserId,
    int? reassignUserId,
    int? reassignTypeId,
    int? permissionID,
  }) async {
    return httpRequest.put(
        '${Endpoints.removeProjectFromUser}?project_id=$projectId&current_user_id=$currentUserId&permission_id=$permissionID');
  }

  // Assign project to respective user
  Future<Response> assignProjectToCP({
    int? projectId,
    int? cpId,
    int? permissionID,
  }) async {
    return httpRequest.put(
        '${Endpoints.assignProjectToChannelPartner}?project_id=$projectId&assign_to_cp_id=$cpId&permission_id=$permissionID');
  }

  // Remove CP from respective project
  Future<Response> removeProjectFromCP({
    int? projectId,
    int? currentUserId,
    int? reassignUserId,
    int? reassignTypeId,
    int? permissionID,
  }) async {
    return httpRequest.put(
        '${Endpoints.removeProjectCp}$currentUserId&project_id=$projectId&permission_id=$permissionID');
  }
}
