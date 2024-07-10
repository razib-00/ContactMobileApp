import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_028/Page/New_contact.dart';
import 'package:test_028/Page/contact_list.dart';
import 'package:test_028/Page/detials.dart';
import 'package:test_028/Provider/contact_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ContactProvider()..GetAllContact()),
        // Add more providers if needed in the future
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: ContactList.routeName,
        routes: {
          ContactList.routeName: (context) => ContactList(),
          AddNew.routeName: (context) => AddNew(),
          Contact_Detials.routeName: (context) => Contact_Detials(),
        },
      ),
    );
  }
}
