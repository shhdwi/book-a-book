import 'dart:collection';

import 'package:catalog_app/services/product_data.dart';
import 'package:flutter/cupertino.dart';

class ProductNotifier with ChangeNotifier{
  List<ProductData> _productList =[];
  late ProductData _currentData;

  UnmodifiableListView<ProductData> get  productList => UnmodifiableListView(_productList);
  ProductData get  currentData => _currentData;

  set productList(List<ProductData> productList){
    _productList= productList;
    notifyListeners();

  }
  set currentData(ProductData current){
    _currentData=current;
    notifyListeners();

  }

}