import 'package:flutter/foundation.dart';
import 'package:test_028/Database/contact_database.dart';
import 'package:test_028/Model/contact_model.dart';

class ContactProvider with ChangeNotifier{
  List<ContactModel>_contactList=[];
  List<ContactModel>get contactList=>_contactList;

  Future<int>insertProvider(ContactModel contactModel)async{
    int insertId=await Db_Helper.insertContact(contactModel);
    return insertId;
  }
  Future<void>GetAllContact()async{
    _contactList=await Db_Helper.getAllContact();
    notifyListeners();
  }
  Future<ContactModel>getProviderContactId(int id)=>Db_Helper.getContactId(id);

  //update
  void Updating(ContactModel contactModel){
    _contactList.add(contactModel);
    notifyListeners();
  }
  ///delete provider method
  void Deleteing(int id){
    Db_Helper.deleteContact(id);
  }
  Future<int> UpdateFavorite(int id, int value)async{
    return await Db_Helper.updateFavorite(id, value);
    //notifyListeners();
  }

}