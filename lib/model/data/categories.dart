
import 'package:flutter/material.dart';

import 'package:shop_app/model/category.dart';

final categoriesItems = {
  Categories.vegetables:  Category(
     'Vegetables',
     Color.fromARGB(255, 0, 255, 128)
),

 Categories.fruits:  Category(
  'Fruits',
  Color.fromARGB(255, 145, 255, 0),
 ),
 Categories.dairy:  Category(
   'Dairy',
    Color.fromARGB(255, 255, 120, 0),
 ),
 Categories.carbs:  Category(
   'Carbs',
    Color.fromARGB(255, 255, 0, 0),
 ),

};