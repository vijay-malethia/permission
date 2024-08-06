import 'package:dio/dio.dart';
import '/api/endpoints.dart';
import '/api/http_request.dart';

class AllUserService {
  Future<Response> getUserListByUserType(
      {int? userId, int? pageCount, int? isActive, String? search}) {
    return httpRequest.get(
        '${Endpoints.getUserListByUserType}?user_type_id=$userId&pagecount=$pageCount${isActive == null ? '' : '&isactive=$isActive'}${search == null ? '' : '&search=$search'}');
  }

  Future<Response> getUserListByChannelPartnerId(
      {int? cpId, int? pageCount, int? isActive, String? search}) {
    return httpRequest.get(
        '${Endpoints.getUserListByChannelPartnerId}?channel_partner_id=$cpId&page_no=$pageCount${isActive == null ? '' : '&isactive=$isActive'}${search == null ? '' : '&search=$search'}');
  }

  Future<Response> getAllTeamMembers(
      {int? pageCount, int? isActive, String? search}) {
    return httpRequest.get(
        '${Endpoints.viewTeamMembers}?page_no=$pageCount${isActive == null ? '' : '&isactive=$isActive'}${search == null ? '' : '&search=$search'}');
  }

  Future<Response> getProjectsToAssignByUserId({int? userId}) {
    return httpRequest.get(
        '${Endpoints.getProjectsToAssignByUserId}?assign_to_user_id=$userId');
  }

  Future<Response> getAssignedProjectsbyUserID({int? userId}) {
    return httpRequest.get(
        '${Endpoints.getAssignedProjectsbyUserID}?projects_for_user_id=$userId');
  }

  Future<Response> assignProjectToUser(
      {required int projectId, required int userId}) {
    return httpRequest.put(
        '${Endpoints.assignProjectToUser}?project_id=$projectId&assign_to_user_id=$userId&permission_id=60');
  }

  Future<Response> changeUserStatus(
      {required bool status, required int userId}) {
    return httpRequest
        .post('${Endpoints.changeUserStatus}?userid=$userId&status=$status');
  }

  // Remove user from respective project
  Future<Response> removeProjectFromUser({
    required int projectId,
    required int currentUserId,
    int? reassignUserId,
    int? reassignTypeId,
  }) async {
    return httpRequest.put(
        '${Endpoints.removeProjectFromUser}?project_id=$projectId&current_user_id=$currentUserId&permission_id=61');
  }
}
