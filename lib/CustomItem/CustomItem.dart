import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_028/Model/contact_model.dart';
import 'package:test_028/Page/detials.dart';
import 'package:test_028/Provider/contact_provider.dart';

class CustomItem extends StatefulWidget {
  final ContactModel contactModel;
  const CustomItem(this.contactModel);

  @override
  State<CustomItem> createState() => _CustomItemState();
}

class _CustomItemState extends State<CustomItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete,
          size: 40,
          color: Colors.white,
        ),
      ),
      confirmDismiss: showConfirmationDialog,
      onDismissed: (_) {
        Provider.of<ContactProvider>(context, listen: false)
            .Deleteing(widget.contactModel.id);
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
          elevation: 5,
          child: ListTile(
            onTap: () {
              Navigator.pushNamed(context, Contact_Detials.routeName,
                  arguments: [
                    widget.contactModel.id,
                    widget.contactModel.name
                  ]);
            },
            title: Text(widget.contactModel.name),
            subtitle: Text(widget.contactModel.mobile),
            trailing: Consumer<ContactProvider>(
              builder: (context,provider,_)=>IconButton(
                onPressed: () {
                  final value=widget.contactModel.favorite?0:1;
                  provider.UpdateFavorite(widget.contactModel.id, value).then((value){
                    setState(() {
                      widget.contactModel.favorite=!widget.contactModel.favorite;
                    });
                  });
                },
                icon: Icon(
                  widget.contactModel.favorite?(Icons.favorite):Icons.favorite_border,
                  color: Colors.red,),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> showConfirmationDialog(DismissDirection direction) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Delete Contact"),
              content: const Text("Sure to Delete this Contact?"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: const Text("CANCEL")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: const Text("YES"))
              ],
            ));
  }
}
