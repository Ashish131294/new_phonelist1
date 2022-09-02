import 'package:flutter/material.dart';
import 'package:new_phonelist_gridview/DbHelper.dart';
import 'package:new_phonelist_gridview/firstpage.dart';
import 'package:sqflite/sqflite.dart';

class viewpage extends StatefulWidget {
  const viewpage({Key? key}) : super(key: key);

  @override
  State<viewpage> createState() => _viewpageState();
}

class _viewpageState extends State<viewpage> {
  List<Map<String, Object?>> l = List.empty();
  bool status=false;
  Database? db;

  @override
  void initState() {
    super.initState();
    getalldata();
  }

  getalldata() async {
    Database db = await DbHelper().createDatabase();
    String qry = "select * from Test";
    List<Map<String, Object?>> l1 = await db!.rawQuery(qry);
    l.addAll(l1);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Contact List"),),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) {
          return firstpage();
        },));
      },),
      body: GridView.builder( itemBuilder: (context, index) {
        Map m = l[index];
        return ListTile(
          leading:Text("${m['id']}"),
        );
      }, gridDelegate: gridDelegate),
    );
  }
}
