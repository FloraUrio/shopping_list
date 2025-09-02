// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shop_app/model/category.dart';
import 'package:shop_app/model/data/categories.dart';
//import 'package:shop_app/model/grocery_item.dart';

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

  void saveItem() async{
    if(formKey.currentState!.validate()){
       formKey.currentState!.save();
       final url = Uri.https('myfirstapp-3df92-default-rtdb.firebaseio.com' , 'shop-app.json');
      final response = await http.post(url,
        headers: {
          'Content-Type' : 'application/json',
       },
       body: json.encode({
        'name': enteredName,
        'quantity': enteredQuantity,
        'category': selectedCategory.name,
    }));
   // print(response.body);
    print(response.statusCode);

    if(!context.mounted){
      return;
    }
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
      // Navigator.of(context).pop();
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

                  ElevatedButton(onPressed: saveItem,
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


