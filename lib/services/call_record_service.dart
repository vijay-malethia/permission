import 'package:dio/dio.dart';
import 'package:sales_lead/api/endpoints.dart';
import 'package:sales_lead/api/http_request.dart';

class CallRecordService {
  Future<Response> getIncomingCallRecods(
      {required int pageCount,
      String? callStatus,
      String? callType,
      String? searchString,
      String? fromDate,
      String? toDate}) async {
    return httpRequest.get(
        '${Endpoints.getIncomingCallRecods}$pageCount${callStatus == null ? '' : '&callstatus=$callStatus'}${callType == null ? '' : '&calltype=$callType'}${searchString == null ? '' : '&search=$searchString'}${fromDate == null ? '' : '&fromdate=$fromDate'}${toDate == null ? '' : '&todate=$toDate'}');
  }

  //dispose call byid
  Future<Response> disposeCallById(int id) async {
    return httpRequest.put('${Endpoints.disposeCall}$id');
  }

  //cloud call api
  Future<Response> connectToCloudCall(
      {String? toNumber, int? leadId, int? followUpId}) async {
    return httpRequest.get(
        '${Endpoints.connectToCall}${toNumber == null ? '' : 'to_number=$toNumber'}${leadId == null ? '' : '&lead_id=$leadId'}${followUpId == null ? '' : '&followup_id=$followUpId'}');
  }
}
