import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:new_phonelist_gridview/DbHelper.dart';
import 'package:new_phonelist_gridview/Viewpage.dart';
import 'package:sqflite/sqflite.dart';

class firstpage extends StatefulWidget {
  const firstpage({Key? key}) : super(key: key);

  @override
  State<firstpage> createState() => _firstpageState();
}

class _firstpageState extends State<firstpage> {

  TextEditingController tname = TextEditingController();
  TextEditingController tcontact = TextEditingController();
Database? db;


  @override
  void initState() {
    super.initState();
    DbHelper().createDatabase().then((value){
      db=value;
    });
  }

  @override
    Widget build(BuildContext context) {
      return Scaffold(appBar: AppBar(title: Text("Phone Number"),),
          body: ListView(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: tname,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Name"),
                    hintText: "Enter Name",
                    suffixIcon: IconButton(
                        onPressed: () {}, icon: Icon(Icons.account_circle))
                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(controller: tcontact,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Contact"),
                    hintText: "Enter Phone Number",
                    suffixIcon: IconButton(
                        onPressed: () {}, icon: Icon(Icons.phone))
                ),),
            ),
            ElevatedButton(onPressed: () async {
              String name = tname.text;
              String contact = tcontact.text;
              String qry="INSERT INTO Test(name,contact) VALUES('$name','$contact')";
              int a= await db!.rawInsert(qry);
              print(a);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return viewpage();
              },));
            }, child: Text("Save"))
          ],)
      );
    }
  }
