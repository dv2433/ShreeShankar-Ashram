import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoice_pdf/report.dart';
import 'Home.dart';

class editnote extends StatefulWidget {
  DocumentSnapshot docid;
  editnote({required this.docid});

  @override
  _editnoteState createState() => _editnoteState(docid: docid);
}

class _editnoteState extends State<editnote> {
  DocumentSnapshot docid;

  _editnoteState({required this.docid});

  TextEditingController donator = TextEditingController();
  TextEditingController remember = TextEditingController();
  TextEditingController date_of_tithi = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController donation = TextEditingController();
  TextEditingController taker = TextEditingController();

  @override
  void initState() {
    donator = TextEditingController(text: widget.docid.get('donator'));
    remember = TextEditingController(text: widget.docid.get('remember'));
    date_of_tithi = TextEditingController(text: widget.docid.get('date_of_tithi'));
    address = TextEditingController(text: widget.docid.get('address'));
    phone = TextEditingController(text: widget.docid.get('phone'));
    donation = TextEditingController(text: widget.docid.get('donation'));
    taker = TextEditingController(text: widget.docid.get('taker'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var widtht = MediaQuery.of(context).size.width;

    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 0, 11, 133),
            leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Home()));
              },
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
              ),
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  widget.docid.reference.delete().whenComplete(() {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => Home()));
                  });
                },
                child: Text(
                  "delete",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 251, 251, 251),
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  widget.docid.reference.update({
                    'donator': donator.text,
                    'remember': remember.text,
                    'date_of_tithi': date_of_tithi.text,
                    'address': address.text,
                    'phone': phone.text,
                    'donation': donation.text,
                    'taker': taker.text,
                  }).whenComplete(() {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => Home()));
                  });
                },
                child: Text(
                  "save",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 251, 251, 251),
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: widtht * 0.09),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: Color.fromARGB(255, 0, 11, 133),
                                size: 35,
                              ),
                              SizedBox(
                                width: widtht * 0.05,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: donator,
                                  cursorColor: Color.fromARGB(255, 0, 11, 133),
                                  decoration: const InputDecoration(
                                    label: Text(
                                      'ભવદિય શ્રી : ',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    floatingLabelStyle: TextStyle(
                                      color: Color.fromARGB(255, 0, 11, 133),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(255, 0, 11, 133),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: Color.fromARGB(255, 0, 11, 133),
                                size: 35,
                              ),
                              SizedBox(
                                width: widtht * 0.05,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: remember,
                                  cursorColor: Color.fromARGB(255, 0, 11, 133),
                                  decoration: const InputDecoration(
                                    label: Text(
                                      'સ્મરણાંથે : ',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    floatingLabelStyle: TextStyle(
                                      color: Color.fromARGB(255, 0, 11, 133),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(255, 0, 11, 133),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: date_of_tithi,
                                  cursorColor: Color.fromARGB(255, 0, 11, 133),
                                  //editing controller of this TextField
                                  decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.date_range,
                                      color: Color.fromARGB(255, 0, 11, 133),
                                      size: 35,
                                    ),
                                    label: Text(
                                      'તિથી તારીખ',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    floatingLabelStyle: TextStyle(
                                      color: Color.fromARGB(255, 0, 11, 133),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(255, 0, 11, 133),
                                      ),
                                    ),
                                  ),
                                  readOnly: true,
                                  //set it true, so that user will not able to edit text
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2100),
                                    );
                                    if (pickedDate != null) {
                                      print(
                                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                      String formattedDate =
                                          DateFormat('dd-MM-yyyy')
                                              .format(pickedDate);
                                      print(
                                          formattedDate); //formatted date output using intl package =>  2021-03-16
                                      setState(() {
                                        date_of_tithi.text =
                                            formattedDate; //set output date to TextField value.
                                      });
                                    } else {}
                                  },
                                ),

                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Color.fromARGB(255, 0, 11, 133),
                                size: 35,
                              ),
                              SizedBox(
                                width: widtht * 0.05,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: address,
                                  cursorColor: Color.fromARGB(255, 0, 11, 133),
                                  decoration: const InputDecoration(
                                    label: Text(
                                      'સરનામું',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    floatingLabelStyle: TextStyle(
                                      color: Color.fromARGB(255, 0, 11, 133),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(255, 0, 11, 133),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.phone,
                                color: Color.fromARGB(255, 0, 11, 133),
                                size: 35,
                              ),
                              SizedBox(
                                width: widtht * 0.05,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: phone,
                                  cursorColor: Color.fromARGB(255, 0, 11, 133),
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    label: Text(
                                      'મોબાઇલ નંબર',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    floatingLabelStyle: TextStyle(
                                      color: Color.fromARGB(255, 0, 11, 133),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(255, 0, 11, 133),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.currency_rupee,
                                color: Color.fromARGB(255, 0, 11, 133),
                                size: 35,
                              ),
                              SizedBox(
                                width: widtht * 0.05,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: donation,
                                  cursorColor: Color.fromARGB(255, 0, 11, 133),
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    label: Text(
                                      'Donation',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    floatingLabelStyle: TextStyle(
                                      color: Color.fromARGB(255, 0, 11, 133),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(255, 0, 11, 133),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: Color.fromARGB(255, 0, 11, 133),
                                size: 35,
                              ),
                              SizedBox(
                                width: widtht * 0.05,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: taker,
                                  cursorColor: Color.fromARGB(255, 0, 11, 133),
                                  decoration: const InputDecoration(
                                    label: Text(
                                      'સ્વીકારનાર',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    floatingLabelStyle: TextStyle(
                                      color: Color.fromARGB(255, 0, 11, 133),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(255, 0, 11, 133),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          MaterialButton(
                            color: Color.fromARGB(255, 0, 11, 133),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => report(
                                    docid: docid,
                                    // image: pickImage,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              "Generate Receipt",
                              style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 251, 251, 251),
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              )),
        ),
        onWillPop: () async {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => Home()));
          return true;
        });
  }
}
