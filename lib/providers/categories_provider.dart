import 'package:flutter/material.dart';

import 'package:admin_dashboard/services/local_storage.dart';

import 'package:admin_dashboard/api/backend_api.dart';
import 'package:admin_dashboard/models/http/category.dart';
import 'package:admin_dashboard/models/http/categories_response.dart';

class CategoriesProvider extends ChangeNotifier {

  List<Categoria> categories = [];


  getCategories() async {
    final resp = await BackendApi.httpGet('/categorias');
    final categoriesResponse = CategoriesResponse.fromJson(resp);
    categories = [...categoriesResponse.categorias];
    notifyListeners();
  }

  Future newCategory(String name) async {
    print('antes del token');
    final token = LocalStorage.prefs.getString('token');
    print('después del token');
    final data = {
      'nombre': name,
    };

    try {
      final json        = await BackendApi.postToken('/categorias', data, token);
      final newCategory = Categoria.fromJson(json);
      categories.add(newCategory);
      notifyListeners();
    }catch (e) {
      print(e);
      print('Error al crear categoria');
    }
  }

}