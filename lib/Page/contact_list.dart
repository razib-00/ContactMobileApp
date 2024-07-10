
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_028/CustomItem/Custom%20Drawer.dart';
import 'package:test_028/CustomItem/CustomItem.dart';
import 'package:test_028/Page/New_contact.dart';
import 'package:test_028/Provider/contact_provider.dart';

class ContactList extends StatefulWidget {
  static const String routeName="/";

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact"),
        backgroundColor: Colors.cyan,
      ),
      body:Consumer<ContactProvider>(
          builder: (context,provider,_)=>ListView.builder(
            itemCount: provider.contactList.length,
            itemBuilder: (context,index){
              final contact=provider.contactList[index];
              return CustomItem(contact);
            },
          )),
      floatingActionButton:FloatingActionButton(
        child:const Icon(Icons.add),
        onPressed: ()=>Navigator.pushNamed(context,AddNew.routeName),
      ),
      drawer: Custom_Drawer(),

    );
  }
}



