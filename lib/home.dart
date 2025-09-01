import 'package:flutter/material.dart';
import 'package:shop_app/model/data/dummy_item.dart';
import 'package:shop_app/model/grocery_item.dart';
import 'package:shop_app/new_item.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<GroceryItem> groceryItem = [];
    void addNewItem() async {
  final newItem = await Navigator.of(context).push<GroceryItem>(MaterialPageRoute(
      builder: (ctx)=> NewItemScreen()));
      if(newItem == null){
        return;

      }
      setState(() {
        groceryItem.add(newItem);
      });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('your Groceries'),
        actions: [
          IconButton(onPressed: addNewItem ,
           icon: Icon(Icons.add)
           ),
        ],
        ),

        body: ListView.builder(
          itemCount: groceryItemList.length,
          itemBuilder: (context, index){
          return ListTile(
            title: Text(groceryItemList[index].name,),
            leading: Container(
              width: 24,
              height: 24,
              color: groceryItemList[index].category.color,
            ),
            trailing: Text(groceryItemList[index].quantity.toString()),

           
            );

            
        })
            
        
          
    );
  }
}