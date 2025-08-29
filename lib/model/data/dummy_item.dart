

import 'package:shop_app/model/category.dart';
import 'package:shop_app/model/data/categories.dart';
import 'package:shop_app/model/grocery_item.dart';

final groceryItemList = [
  GroceryItem(
    id: "1",
    name: "Milk",
    quantity: 1,
    category: categoriesItems[Categories.dairy]!, 
    
  ),
   GroceryItem(
    id: "1",
    name: "Bananas",
    quantity: 5,
    category: categoriesItems[Categories.fruits]!,
    
  ),

   GroceryItem(
    id: "1",
    name: "Beef",
    quantity: 1,
    category: categoriesItems[Categories.carbs]!,
    
  ),

];


