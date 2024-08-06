import 'package:dio/dio.dart';
import 'package:sales_lead/api/endpoints.dart';
import 'package:sales_lead/api/http_request.dart';

class HomeService {
  Future<Response> getDashBoardV2() async {
    return httpRequest.get(Endpoints.dashBoardV2);
  }
}
