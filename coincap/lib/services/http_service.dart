import 'package:dio/dio.dart';
import '../models/app_config.dart';
import 'package:get_it/get_it.dart';

class HttpService {
  final Dio dio = Dio();
  late final AppConfig _appConfig;
  late final String _baseUrl;

  HttpService() {
    // Get AppConfig instance from GetIt
    _appConfig = GetIt.I.get<AppConfig>();
    _baseUrl = _appConfig.COIN_API_BASE_URL;
  }

  Future<Response?> get(String path) async {
    try {
      final url = '$_baseUrl$path';
      final response = await dio.get(url);
      print(" Response received from $url");
      return response;
    } catch (e) {
      print(" HttpService: Unable to perform GET request.");
      print(e);
      return null;
    }
  }
}
