import 'package:admin_dashboard/services/notifications_services.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/api/backend_api.dart';

import 'package:admin_dashboard/models/http/auth_response.dart';

import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/services/local_Storage.dart';
import 'package:admin_dashboard/services/navigation_service.dart';

enum AuthStatus {
  checking,
  authenticated,
  notAuthenticated,
}

class AuthProvider extends ChangeNotifier {
  AuthStatus authStatus = AuthStatus.checking;
  Usuario? user;

  AuthProvider() {
    isAuthenticated();
  }

  login(String email, String password) {
    final data = {
      'correo': email,
      'password': password,
    };

    BackendApi.post('/auth/login', data).then((json) {

      final authResponse = AuthResponse.fromJson(json);
      user = authResponse.usuario;

      authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString('token', authResponse.token);
      NavigationService.replaceTo(Flurorouter.dashboardRoute);
      
      BackendApi.configureDio();
      notifyListeners();
    }).catchError((e) {
      NotificationsService.showSnackbarError('Usuario / Password no valido');
    });

    // isAuthenticated();
  }

  register(String email, String password, String name) {
    final data = {
      "nombre": name,
      "correo": email,
      "password": password,
    };

    BackendApi.post('/usuarios', data).then((json) {
      final authResponse = AuthResponse.fromJson(json);

      user = authResponse.usuario;

      authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString('token', authResponse.token);
      NavigationService.replaceTo(Flurorouter.dashboardRoute);

      BackendApi.configureDio();
      notifyListeners();
    }).catchError((e) {
      NotificationsService.showSnackbarError('Usuario / Password no valido');
    });
  }

  Future<bool> isAuthenticated() async {
    final token = LocalStorage.prefs.getString('token');
    if (token == null) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }

    try {
      final resp          = await BackendApi.httpGetToken('/auth', token);
      final authResponse  = AuthResponse.fromJson(resp);
      LocalStorage.prefs.setString('token', authResponse.token);

      user = authResponse.usuario;
      authStatus = AuthStatus.authenticated;
      notifyListeners();
      return true;

    } catch (e) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }
  }

  logout(){
    LocalStorage.prefs.remove('token');
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
  }

}
