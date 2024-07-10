

import 'package:flutter/material.dart';
import 'package:test_028/Page/New_contact.dart';
import 'package:test_028/Page/contact_list.dart';

class Custom_Drawer extends StatelessWidget {
  const Custom_Drawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.lightBlueAccent,
        child:ListView(
          children: [
            const  UserAccountsDrawerHeader(accountName: Text("Kazi Shoabul Islam Razib"), accountEmail: Text("kazisirazib777@gmail.com")),
            ListTile(
                leading:const Icon(Icons.home),
                title:  const Text("Home"),
                onTap:(){
                  Navigator.pushNamed(context,ContactList.routeName);
                }
            ),
            ListTile(
                leading:const  Icon(Icons.add),
                title:  const Text("Add New"),
                onTap:(){
                  Navigator.pushNamed(context,AddNew.routeName);
                }
            ),

          ],
        )
    );
  }
}
