import 'package:dio/dio.dart';
import 'package:sales_lead/api/endpoints.dart';
import 'package:sales_lead/api/http_request.dart';

class CPService {
  //get channel partnet list
  Future<Response> getCpList(String id, int pageCount) async {
    return httpRequest.get('${Endpoints.cpList}$id&pagecount=$pageCount');
  }

  //serach api
  Future<Response> getCpSearchList(
      String id, int pageCount, String searchString) async {
    return httpRequest.get(
        '${Endpoints.cpList}$id&pagecount=$pageCount&search=$searchString');
  }

  //cp details
  Future<Response> getCpDetails(int id) async {
    return httpRequest.get('${Endpoints.cpDetails}$id');
  }

  //get cp active users
  Future<Response> getCpActiveUsers(int id, bool isActive) async {
    return httpRequest.get('${Endpoints.cpActiveUser}$id&is_active=$isActive');
  }

  //get cp active users
  Future<Response> getCpCurrentProject(int id, int isActive) async {
    return httpRequest
        .get('${Endpoints.cpCurrentProject}$id&is_active=$isActive');
  }

  //post cp accept or reject
  Future<Response> cpAcceptReject(int id, bool isAccept) async {
    return httpRequest
        .post('${Endpoints.cpAcceptReject}$id&is_approved=$isAccept');
  }

  //post cp deactive
  Future<Response> cpDeactive(int id) async {
    return httpRequest.post('${Endpoints.cpDeactive}$id');
  }

  //get project list
  Future<Response> getCpAssignProjectList(int chId) async {
    return httpRequest.get('${Endpoints.cpAssignProjectList}$chId');
  }

  //put cp deactive
  Future<Response> cpAssignProject(int chId, int projectId) async {
    return httpRequest.put(
        '${Endpoints.cpAssignProject}$projectId&assign_to_cp_id=$chId&permission_id=62');
  }

  //get project list for remove
  Future<Response> getCpProjectForRemove(int chId) async {
    return httpRequest.get('${Endpoints.cpProjectForRemove}$chId');
  }

  //get project list for remove
  Future<Response> getUserToReassignCPLead(
      int projectId, int? existingUserId) async {
    return httpRequest.get(
        '${Endpoints.getUserToReassignCPLead}$projectId${existingUserId == null ? '' : '&existing_user_id=$existingUserId'}');
  }

  //remove Project from  Cp
  Future<Response> removeProjectFromCp(
      {required int chId,
      int? projectId,
      int? assignToUserId,
      int? reassignTypeId}) async {
    return httpRequest.put(
        '${Endpoints.removeProjectCp}$chId${projectId == null ? '' : '&project_id=$projectId'}${assignToUserId == null ? '' : '&assign_to_user_id=$assignToUserId'}${reassignTypeId == null ? '' : '&reassign_type_id=$reassignTypeId'}${'&permission_id=63'}');
  }
}
