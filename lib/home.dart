import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shop_app/model/category.dart';
import 'package:shop_app/model/data/categories.dart';

import 'package:shop_app/model/grocery_item.dart';
import 'package:shop_app/new_item.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

   List<GroceryItem> groceryItem = [];

@override
  void initState(){
    super.initState();
    loadItem();
  }


  void loadItem() async{
   final url =
    Uri.https('myfirstapp-3df92-default-rtdb.firebaseio.com','shop-app/json');
     final response = await http.get(url);
     final Map<String, dynamic> listedItems = json.decode(response.body);

      final List<GroceryItem> loadedItems = [];
      for(final item in listedItems.entries){
        final category = categoriesItems.values.firstWhere((cat) =>
       cat.name == item.value['category']);
        loadedItems.add(
         GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category,
         ) 
        );
      }   
      setState(() {
        groceryItem = loadedItems;
      });
      
  }


    void addNewItem() async {
   await Navigator.of(context).push<GroceryItem>(MaterialPageRoute(
      builder: (ctx)=> NewItemScreen()));
   
  }



void onRemove(GroceryItem item){
  setState(() {
      groceryItem.remove(item);
  });
}


  @override
  Widget build(BuildContext context) {

    Widget mainContent = Center(
  child: Text('no item added here....'),
);
   if (groceryItem.isNotEmpty){
     mainContent=

      ListView.builder(
          itemCount: groceryItem.length,
          itemBuilder: (context, index){
          return Dismissible(
            key: ValueKey(groceryItem[index].id),
            onDismissed: (direction) => onRemove(groceryItem[index]),
            child: ListTile(
              title: Text(groceryItem[index].name,),
              leading: Container(
                width: 24,
                height: 24,
                color: groceryItem[index].category.color,
              ),
              trailing: Text(groceryItem[index].quantity.toString()),
              ),
          );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('your Groceries'),
        actions: [
          IconButton(onPressed: addNewItem ,
           icon: Icon(Icons.add)
           ),
        ],
        ),

        body: mainContent,
            
        
          
    );
  }
}

