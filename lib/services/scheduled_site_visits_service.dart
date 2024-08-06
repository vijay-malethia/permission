import 'package:dio/dio.dart';
import 'package:sales_lead/api/endpoints.dart';
import 'package:sales_lead/api/http_request.dart';

class ScheduledSiteVisitsService {
  //get scheduled site visits list
  Future<Response> getScheduledSiteVisit(String? date, int pageCount) {
    return httpRequest
        .get('${Endpoints.scheduledSiteVisits}$pageCount${date == null ? '' : '&date=$date'}');
  }

  //get otp
  Future<Response> getSiteVisitCode(int siteId) {
    return httpRequest.get('${Endpoints.getSiteVisitCode}$siteId');
  }

//complete site visit
  Future<Response> completeSiteVisit({int? followUpId,int? leadCode,int? userCode}) {
    return httpRequest.put('${Endpoints.completeSiteVisit}${followUpId == null ? '' : '&followup_id=$followUpId'}${leadCode == null ? '' : '&lead_code=$leadCode'}${userCode == null ? '' : '&user_code=$userCode'}');
  }

    //get schedule site visit count date list
 Future<Response> getScheduleSiteVisitCount(String date) {
    return httpRequest.get('${Endpoints.getUpScheduleSiteVisitCount}$date');
  }
  
}
