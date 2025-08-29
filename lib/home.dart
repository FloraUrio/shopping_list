import 'package:flutter/material.dart';
import 'package:shop_app/model/data/dummy_item.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('your Groceries'),
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