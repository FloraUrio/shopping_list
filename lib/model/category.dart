import 'package:flutter/material.dart';

enum Categories {
  vegetables,
  fruits,
  meat,
  dairy,
  carbs,
}


class Category {
   Category( 

 this.name,
 
  this.color,
);

  
  final String name;
 
  final Color color;
}