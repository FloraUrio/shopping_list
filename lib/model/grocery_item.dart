// ignore_for_file: constant_identifier_n

import 'package:shop_app/model/category.dart';

class GroceryItem {

  final String id;
  final String name;
  final int quantity;
  final Category category;

  GroceryItem( {required this.category, required this.id, required this.name, required this.quantity});
}