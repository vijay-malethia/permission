import 'package:dio/dio.dart';
import 'package:sales_lead/api/endpoints.dart';
import 'package:sales_lead/api/http_request.dart';
import 'package:sales_lead/app/app.locator.dart';

import 'shared_service.dart';

class LeadService {
  Future<Response> getActiveProjects() async {
    return httpRequest.get(Endpoints.getActiveProjects);
  }

  Future<Response> getUnitTypesByProjectId(String id) async {
    return httpRequest.get(Endpoints.getUnitTypesByProjectId + id);
  }

  Future<Response> createLead(data) async {
    return httpRequest.post(Endpoints.createLead, data: data);
  }

  final _sharedService = locator<SharedService>();
  //Lead
  Future<Response> getViewLeadsBySource({
    required int userTypeId,
    required int pageNo,
    int? leadStageId,
    String? search,
    int? isUnassigned,
    String? projectId,
    String? userId,
    String? cpId,
  }) async {
    return httpRequest.get(
        '${_sharedService.userId == 2 ? Endpoints.getLeadListByChannelPartnerId : Endpoints.viewLeadsBySource}${_sharedService.userId == 2 ? '?channel_partner_id=$userTypeId' : '?user_type_id=$userTypeId'}&page_no=$pageNo${search == null ? '' : '&search=$search'}${isUnassigned == null ? '' : '&is_unassigned=$isUnassigned'}${projectId == null ? '' : '&project_id=$projectId'}${userId == null ? '' : '&userid=$userId'}${cpId == null ? '' : '&cp_ids=$cpId'}${leadStageId == null ? '' : '&lead_stage_id=$leadStageId'}');
  }

  Future<Response> getLeadCurrentStages() async {
    return httpRequest.get(Endpoints.getLeadCurrentStages);
  }

  Future<Response> getAssignedLeads({
    int? leadStageId,
    required int pageNo,
    String? search,
    String? projectId,
  }) async {
    return httpRequest.get(
        '${Endpoints.getAssignedLeads}?page_no=$pageNo${leadStageId == null ? '' : '&lead_stage_id=$leadStageId '}${search == null ? '' : '&search=$search'}${projectId == null ? '' : '&project_id=$projectId'}');
  }

  //Assign Lead Bottom Sheet data
  Future<Response> getActiveDSTListByLeadId(leadId) async {
    return httpRequest.get('${Endpoints.getActiveDSTListByLeadId}$leadId');
  }

  Future<Response> leadAssignment(data) async {
    return httpRequest.post(Endpoints.leadAssignment, data: data);
  }

  Future<Response> leadStageUpdate(data) async {
    return httpRequest.post(Endpoints.leadStageUpdate, data: data);
  }

  Future<Response> getUserListForLeadFilter() async {
    return httpRequest.get(Endpoints.getUserListForLeadFilter);
  }

  Future<Response> getActiveProjectsForFilter() async {
    return httpRequest.get(Endpoints.getActiveProjectsForFilter);
  }

  Future<Response> activeChannelPartnersList() async {
    return httpRequest.get(Endpoints.activeChannelPartnersList);
  }

  /////////////////////////////////////////////////Schedule Follow  Up///////////////////////////////////////////////////
  Future<Response> getFollowupTypes() async {
    return httpRequest.get(Endpoints.getFollowupTypes);
  }

  Future<Response> getFollowupTimeUnits() async {
    return httpRequest.get(Endpoints.getFollowupTimeUnits);
  }

  Future<Response> scheduleFollowup(data) async {
    return httpRequest.post(Endpoints.scheduleFollowup, data: data);
  }

  Future<Response> getFollowupById(id) async {
    return httpRequest.get('${Endpoints.getFollowupById}$id');
  }

  Future<Response> editFollowUp(data) async {
    return httpRequest.put(Endpoints.editFollowUp, data: data);
  }

  Future<Response> getListOfCallRecordsByLeadId(
      {leadId, pageNo, search}) async {
    return httpRequest.get(
        '${Endpoints.getListOfCallRecordsByLeadId}$leadId${pageNo == null ? '' : '&page_no=$pageNo'}${search == null ? '' : '&search=$search'}');
  }

  //////////////////////////////////////////////////Follow Up/////////////////////////////////////////////////////////////////
  Future<Response> getFollowupsByLeadId(
      {leadId, pageNo, followUpStatusId, followUpTypeSearch}) async {
    return httpRequest.get(
        '${Endpoints.getFollowupsByLeadId}${leadId == null ? '' : '?lead_id=$leadId'}${pageNo == null ? '' : '&page_no=$pageNo'}${followUpStatusId == null ? '' : '&followup_status_id=$followUpStatusId'}${followUpTypeSearch == null ? '' : '&followup_type_search=$followUpTypeSearch'}');
  }

  Future<Response> getFollowupStatusForSearch() async {
    return httpRequest.get(Endpoints.getFollowupStatusForSearch);
  }

  Future<Response> updateFollowUpStatus(formData) async {
    return httpRequest.put(Endpoints.updateFollowUpStatus, data: formData);
  }
}
