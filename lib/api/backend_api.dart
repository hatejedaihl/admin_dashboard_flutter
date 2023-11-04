import 'package:dio/dio.dart';

import 'package:admin_dashboard/services/local_storage.dart';

class BackendApi {
  static Dio _dio = Dio();

  static void configureDio() {
    // Base del url
    _dio.options.baseUrl = 'http://localhost:8090/api';

    // Configurar Headers
    _dio.options.headers = {
      'x-token': LocalStorage.prefs.getString('token') ?? '',
    };

    // _dio.options = BaseOptions(
    //   baseUrl: 'http://localhost:8090/api',
    //   headers: {
    //     'x-token': LocalStorage.prefs.getString('token') ?? '',
    //   }
    // );
  }

  static Future httpGet(String path) async {
    try {
      final resp = await _dio.get(path);
      return resp.data;
    } catch (e) {
      throw ('Error en el GET');
    }
  }

  static Future httpGetToken(String path, String token) async {
    try {
      final resp =
          await _dio.get(path, options: Options(headers: {'x-token': token}));
      return resp.data;
    } catch (e) {
      throw ('Error en el GET');
    }
  }

  static Future post(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);

    try {
      final resp = await _dio.post(path, data: formData);
      return resp.data;
    } catch (e) {
      throw ('Error en el POST');
    }
  }

  static Future postToken(
      String path, Map<String, dynamic> data, String? token) async {
    final formData = FormData.fromMap(data);

    try {
      final resp = await _dio.post(path,
          data: formData, options: Options(headers: {'x-token': token}));
      return resp.data;
    } catch (e) {
      throw ('Error en el POST');
    }
  }
}
