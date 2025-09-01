// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:shop_app/model/category.dart';
import 'package:shop_app/model/data/categories.dart';
import 'package:shop_app/model/grocery_item.dart';

class NewItemScreen extends StatefulWidget {
  const NewItemScreen({super.key});

  @override
  State<NewItemScreen> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {

  final formKey = GlobalKey<FormState>();
  var enteredName = '';
  var enteredQuantity = 1 ;
  var selectedCategory = categoriesItems[Categories.vegetables]!;

  void saveItem(){
    if(formKey.currentState!.validate()){
       formKey.currentState!.save();
       Navigator.of(context).pop(GroceryItem(
        id: DateTime.now().toString(),
        name: enteredName,
         quantity: enteredQuantity,
        category: selectedCategory,  ));
    }
   
    //formKey.currentState!.reset();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('add a new item')),

      body: Padding(
        padding: EdgeInsets.all(12),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: InputDecoration(label: Text('name')),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return 'must be between 1 and 50';
                  }
                  return null;
                },
                onSaved:(value) {
                  if(value == null){
                    return;
                  }
                  enteredName = value;
                },
              ),
              SizedBox(height: 18),

              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(label: Text('quantity')),
                      initialValue: enteredQuantity.toString(),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! <= 0) {
                          return 'must be positive number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        enteredQuantity = int.parse(value!);
                      },
                    ),
                  ),
                  SizedBox(width: 19),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: selectedCategory,
                      items: [
                        for (final category in categoriesItems.entries)
                          DropdownMenuItem(
                            value: category.value,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: category.value.color,
                                ),
                                SizedBox(width: 6),
                                Text(category.value.name),
                              ],
                            ),
                          ),
                      ],
                      onChanged: (value) {
                        setState(() {
                           selectedCategory = value!;
                        });
                       
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () {
                    formKey.currentState!.reset();
                  },
                   child: Text('Reset')),

                  ElevatedButton(onPressed: () {
                    formKey.currentState!.save();
                  },
                   child: Text('add new')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


