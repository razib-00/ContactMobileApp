import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_028/CustomItem/Custom%20Drawer.dart';
import 'package:test_028/Model/contact_model.dart';
import 'package:test_028/Provider/contact_provider.dart';

class AddNew extends StatefulWidget {
  static const String routeName = "/addnew";

  @override
  State<AddNew> createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  final _formKey = GlobalKey<FormState>();
  final _controllerName = TextEditingController();
  final _controllerMobile = TextEditingController();
  final _controllerEmail = TextEditingController();
  final _controllerAddress = TextEditingController();
  final _controllerGPO = TextEditingController();
  final _controllerCompany = TextEditingController();
  final _controllerDesignation = TextEditingController();
  final _controllerWebsite = TextEditingController();

  late ContactProvider _provider;

  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _provider = Provider.of<ContactProvider>(context, listen: false);
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerMobile.dispose();
    _controllerEmail.dispose();
    _controllerAddress.dispose();
    _controllerGPO.dispose();
    _controllerCompany.dispose();
    _controllerDesignation.dispose();
    _controllerWebsite.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Contact"),
        actions: [
          IconButton(onPressed: _save, icon: const Icon(Icons.save)),
        ],
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Card(
                elevation: 5,
                child: TextFormField(
                  controller: _controllerName,
                  decoration: const InputDecoration(labelText: "*Name"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field must not be empty";
                    }
                    if (value.length > 20) {
                      return "This field less than 20 characters";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 5),
              Card(
                elevation: 5,
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: _controllerMobile,
                  decoration: const InputDecoration(labelText: "*Phone"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field must not be empty";
                    }
                    if (value.length > 14) {
                      return "This field less than 14 characters";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 5),
              Card(
                elevation: 5,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _controllerEmail,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
              ),
              const SizedBox(height: 5),
              Card(
                elevation: 5,
                child: TextFormField(
                  keyboardType: TextInputType.streetAddress,
                  controller: _controllerAddress,
                  decoration: const InputDecoration(labelText: "Street Address"),
                ),
              ),
              const SizedBox(height: 5),
              Card(
                elevation: 5,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _controllerGPO,
                  decoration: const InputDecoration(labelText: "GPO/POST CODE"),
                ),
              ),
              const SizedBox(height: 5),
              Card(
                elevation: 5,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _controllerCompany,
                  decoration:const InputDecoration(labelText: "Company"),
                ),
              ),
              const SizedBox(height: 5),
              Card(
                elevation: 5,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _controllerDesignation,
                  decoration: const InputDecoration(labelText: "Designation"),
                ),
              ),
              const SizedBox(height: 5),
              Card(
                elevation: 5,
                child: TextFormField(
                  keyboardType: TextInputType.url,
                  controller: _controllerWebsite,
                  decoration:const InputDecoration(labelText: "Website"),
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
      drawer: const Custom_Drawer(),
    );
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final  _contact = ContactModel(
        name: _controllerName.text,
        mobile: _controllerMobile.text,
        email: _controllerEmail.text,
        address: _controllerAddress.text,
        gpo: _controllerGPO.text,
        company: _controllerCompany.text,
        designation: _controllerDesignation.text,
        website: _controllerWebsite.text,
      );
      _provider.insertProvider(_contact).then((rowId) {
        _contact.id = rowId;
        _provider.Updating(_contact);
        Navigator.pop(context);
      }).catchError((error) {
        throw error;
      });
    }
  }
}
