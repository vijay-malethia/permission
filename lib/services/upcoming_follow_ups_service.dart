

import 'package:dio/dio.dart';
import 'package:sales_lead/api/endpoints.dart';
import 'package:sales_lead/api/http_request.dart';

class UpcomingFollowUpServices {
  //get upcoming follow ups list
 Future<Response> getUpComingFollowUps({int? pageNo,String? followUpType,String? date}) {
    return httpRequest.get('${Endpoints.getUpComingFollowUps}${pageNo == null ? '' : '&page_no=$pageNo'}${followUpType == null ? '' : '&followup_type_search=$followUpType'}${date == null ? '' : '&date=$date'}');
  }
  
  //get upcoming follow ups count date list
 Future<Response> getUpcomingFollowUpsCount(String date) {
    return httpRequest.get('${Endpoints.getUpcomingFollowUpsCount}$date');
  }
}