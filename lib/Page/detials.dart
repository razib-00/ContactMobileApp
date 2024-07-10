import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_028/CustomItem/Custom%20Drawer.dart';
import 'package:test_028/Model/contact_model.dart';
import 'package:test_028/Provider/contact_provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Contact_Detials extends StatefulWidget {
  static const String routeName = "/contact_details";

  @override
  State<Contact_Detials> createState() => _Contact_DetialsState();
}

class _Contact_DetialsState extends State<Contact_Detials> {
  @override
  Widget build(BuildContext context) {
    final argList = ModalRoute.of(context)!.settings.arguments as List;
    final id = argList[0];
    final name = argList[1];
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.pinkAccent[400],
      ),
      body: Center(
        child: Consumer<ContactProvider>(
          builder: (context, provider, _) => FutureBuilder<ContactModel>(
              future: provider.getProviderContactId(id),
              builder: (context, snapshort) {
                if (snapshort.hasData) {
                  final contact = snapshort.data;
                  return buildListView(contact);
                }
                if (snapshort.hasError) {
                  return const Text("Failed to fatch data");
                }
                return const CircularProgressIndicator();
              }),
        ),
      ),
      drawer:const  Custom_Drawer(),
    );
  }

  Widget buildListView(ContactModel? contact) {
    return ListView(
      padding: const EdgeInsets.all(08),
      children: [
        Image.network(contact!.image,
            width: double.infinity, height: 250, fit: BoxFit.cover),
        Card(
          elevation: 10,
          child: ListTile(
            title: Text(contact.mobile),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: () {
                  _callContact(contact.mobile);
                }, icon: const Icon(Icons.call,color: Colors.lightBlue,)),
                IconButton(onPressed: () {
                  _smsContact(contact.mobile);
                }, icon: const Icon(Icons.sms,color: Colors.amber,))
              ],
            ),
          ),
        ),
        Card(
          elevation: 10,
          child: ListTile(
            title:  Text(contact.email),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(onPressed: (){
                  _emailContact(contact.email);
                },
                    child: const Icon(Icons.email,size: 30,color: Colors.pinkAccent,)),
              ],
            ),
          ),
        ),
        Card(
          elevation: 10,
          child: ListTile(
            title: Text(contact.address),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: () {
                  _mapContact(contact.address);
                }, icon: const Icon(Icons.map,color: Colors.deepOrange,)),
              ],
            ),
          ),
        ),
        Card(
          elevation: 10,
          child: ListTile(
            title: Text(contact.website),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: () {
                  _webContact(contact.website);
                }, icon: const Icon(Icons.web,color: Colors.deepPurpleAccent,)),
              ],
            ),
          ),
        ),
        Card(
          elevation: 10,
          child: ListTile(
            title:  Text(contact.designation,
              style: const TextStyle(fontSize: 30,color: Colors.lightBlueAccent),),
          ),
        ),Card(
          elevation: 10,
          child: ListTile(
            title:  Text(contact.company),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(onPressed: (){
                  _company(contact.company);
                },
                    child: const Icon(Icons.map,size: 30,color: Colors.green,)),
              ],
            ),
          ),
        )
      ],
    );
  }


  void _emailContact(String email) async{
    final uri="mailto:$email";
    if(await canLaunchUrlString(uri)){
      await launchUrlString(uri);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could Not Launch Application!"),));
      throw "Could not launch application!";
    }
  }
  

  void _smsContact(String mobile) async{
    final uri="sms:$mobile";
    if(await canLaunchUrlString(uri)){
      await launchUrlString(uri);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
         const  SnackBar(content: Text("could Not Launch Application!"),));
      throw "Could not launch application!";
    }
  }

  void _callContact(String mobile) async{
    final uri="tel:$mobile";
    if(await canLaunchUrlString(uri)){
      await launchUrlString(uri);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could Not Launch Application!")));
      throw "Could not launch application!";
    }
  }

  void _mapContact(String address) async{
  }

  void _webContact(String website) async{
    final uri="https:$website";
    if(await canLaunchUrlString(uri)){
      await launchUrlString(uri);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Could Not Launch Application!")));
      throw "Could not launch application!";
    }
  }

  void _company(String company) {}
}
