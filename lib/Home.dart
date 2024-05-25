import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'addnote.dart';
import 'editnote.dart';
import 'dart:io';

class Home extends StatefulWidget {
  static File? image;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final picker = ImagePicker();

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('receipt').snapshots();

  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Do you want to exit app?'),
        actions: [
          ElevatedButton(onPressed: () => Navigator.pop(context,false), child: Text('No'),style: ElevatedButton.styleFrom(primary: Color.fromARGB(255, 0, 11, 133),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),),
          ElevatedButton(onPressed: () => Navigator.pop(context,true), child: Text('Yes'),style: ElevatedButton.styleFrom(primary: Color.fromARGB(255, 0, 11, 133),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),),
        ],
      )
  );

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var widtht = MediaQuery.of(context).size.width;

    return WillPopScope(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 0, 11, 133),
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => addnote()));
            },
            child: Icon(
              Icons.add,
            ),
          ),
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 0, 11, 133),
            title: Text('Receipt'),

            actions: [
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () async {
                  pickImage();
                },
              ),
            ],
          ),
          body: StreamBuilder(
            stream: _usersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("something is wrong");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.005,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: widtht * 0.04,
                              ),
                              Container(
                                width: widtht * 0.75,
                                child: Text(
                                  snapshot
                                      .data!.docChanges[index].doc['donator'],
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => editnote(
                                          docid: snapshot.data!.docs[index]),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    shadowColor:
                                        Color.fromARGB(255, 1, 11, 133),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: Icon(
                                  Icons.edit,
                                  color: Color.fromARGB(255, 0, 11, 133),
                                  size: 35,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.006,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
        onWillPop: () async {
          final shouldPop = await showWarning(context);
          return shouldPop ?? false;
        }
        );
  }
  pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile!= null) {
        Home.image = File(pickedFile.path);
      }
      else {
        print('No image selectd');
      }
    });
  }
}