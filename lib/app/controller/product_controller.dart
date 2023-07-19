import 'package:app_good_taste/app/model/flavor_model.dart';
import 'package:app_good_taste/app/model/product_model.dart';
import 'package:flutter/material.dart';

class ProductController extends ChangeNotifier {
  List<Map<String, dynamic>> _items = <Map<String, dynamic>>[];

  List<Map<String, dynamic>> get items {
    return [..._items];
  }

  Future<void> loadProducts() async {
    final products = await ProductModel.getData();
    _items = products;
    notifyListeners();
  }

  Future<void> delete(int id) async {
    await ProductModel.delete(id);
    notifyListeners();
  }

  Future<void> save(
      int id, String name, double price, List<FlavorModel> flavors) async {
    // final Map<String, dynamic> newProduct = {
    //   "id": id,
    //   "name": name,
    //   "price": price,
    //   "flavors": flavors,
    // };

    // _items.add(newProduct);

    await ProductModel.save(flavors, {
      "name": name,
      "id": id,
      "price": price,
    });
    notifyListeners();
  }
}
