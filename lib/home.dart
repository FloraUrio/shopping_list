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
  var isLoading = true;
  String? errorMessage;

@override
  void initState(){
    super.initState();
    loadItem();
  }


  void loadItem() async {
  
   final url = Uri.https('myfirstapp-3df92-default-rtdb.firebaseio.com' , 'shop-app.json');
      final response = await http.get(url);

     // print(response.body);
     //print(response.statusCode);

    try{
      
 if(response.statusCode >= 400){
      setState(() {
         errorMessage = 'something went wrong... please try again later';
      });
     }

     if(response.body == 'null'){
      setState(() {
         isLoading = false;
      });
      
     }

      final Map<String, dynamic> listedItems = 
        json.decode(response.body);

      final List<GroceryItem> loadedItems = [];
      for(final item in listedItems.entries){
        final category = categoriesItems.entries.
        firstWhere((catItem) =>
       catItem.value.name == item.value['category']).value;
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
        isLoading = false;
      });

    }
    catch(error){
      setState(() {
        errorMessage = 'something went wrong... please try again';
       });
    }

    
   
      
  }


    void addNewItem() async {
  final newItem = await Navigator.of(context).push<GroceryItem>(MaterialPageRoute(
      builder: (ctx)=> NewItemScreen()));
    
    if(newItem == null){
      return;
    }
    groceryItem.add(newItem);
    isLoading = false;
  }



void onRemove(GroceryItem item)async{
  final index = groceryItem.indexOf(item);

   setState(() {
      groceryItem.remove(item);
  });

 final url = Uri.https('myfirstapp-3df92-default-rtdb.firebaseio.com' , 'shop-app/${item.id}.json');
    final response = await  http.delete(url,);

      if(response.statusCode >= 400){
        setState(() {
         groceryItem.insert(index, item); 
        });
        
       }
}


  @override
  Widget build(BuildContext context) {

    Widget mainContent = Center(
  child: Text('no item added here....'),
);

if (isLoading){
  mainContent = Center (
    child: CircularProgressIndicator());
}
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

    if(errorMessage != null){
      mainContent = Center(
        child: Text(errorMessage!));
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

