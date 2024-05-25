import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:invoice_pdf/addnote.dart';

import 'package:path_provider/path_provider.dart';

import 'Home.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'Home',
    routes: {
      'Home' : (context) => Home(),
      'addNote' : (context) => addnote(),
    },
  )
  );
}
