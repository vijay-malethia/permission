import '/api/http_request.dart';
import '/app/app.locator.dart';
import '/services/index.dart';

class AppService {
  final AuthService _authService = locator<AuthService>();
  final SharedService _sharedService = locator<SharedService>();

  Future bootstrap() async {
    // Initiate dio instance
    initDio();
    await _authService.prepareUserSession();
    if (_authService.isAuthorized) {
      await _sharedService.prepareUserPermission();
    }
  }
}
