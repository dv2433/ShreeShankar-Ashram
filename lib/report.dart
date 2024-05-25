import 'dart:math';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'Home.dart';
import 'convertNumberToWords.dart';

class report extends StatefulWidget {
  DocumentSnapshot docid;

  report({required this.docid});

  @override
  State<report> createState() => _reportState(docid: docid);
}

class _reportState extends State<report> {
  DocumentSnapshot docid;

  _reportState({required this.docid});

  final pdf = pw.Document();
  var donator;
  var remember;
  var date_of_tithi;
  var address;
  var phone;
  var donation;
  var taker;
  var word;
  var donationInWord;

  void initState() {
    setState(() {
      donator = widget.docid.get('donator');
      remember = widget.docid.get('remember');
      date_of_tithi = widget.docid.get('date_of_tithi');
      address = widget.docid.get('address');
      phone = widget.docid.get('phone');
      donation = widget.docid.get('donation');
      taker = widget.docid.get('taker');

      word = int.parse(donation.toString());
      assert(word is int);
      donationInWord = convertNumberToWords(word);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PdfPreview(
      // maxPageWidth: height*3.0,
      // useActions: false,
      canChangePageFormat: true,
      canChangeOrientation: false,
      // pageFormats:pageformat,
      canDebug: false,
      build: (format) => generateDocument(
        format,
      ),
    );
  }

  Future<Uint8List> generateDocument(PdfPageFormat format) async {
    final doc = pw.Document(pageMode: PdfPageMode.outlines);
    final font1 = await PdfGoogleFonts.openSansRegular();
    final font2 = await PdfGoogleFonts.openSansBold();
    final font3 = await PdfGoogleFonts.balooBhai2Bold();

    var height = MediaQuery.of(context).size.height;
    var widtht = MediaQuery.of(context).size.width;

    DateTime today = DateTime.now();
    String date = "${today.day}-${today.month}-${today.year}";

    Random random = new Random();
    int randomNumber = random.nextInt(100000);
    int randomNumber2 = random.nextInt(10000);

    final image1;
    if(Home.image==null){
      image1 = await imageFromAssetBundle('image/A1.png');
    }
    else{
      image1 = pw.MemoryImage(Home.image!.readAsBytesSync());
    }

    final image2 = await imageFromAssetBundle('image/A2.png');
    final image3 = await imageFromAssetBundle('image/A3.png');
    final image11 = await imageFromAssetBundle('image/B1.png');
    final image12 = await imageFromAssetBundle('image/B2.png');
    final image13 = await imageFromAssetBundle('image/B3.png');
    final image14 = await imageFromAssetBundle('image/B4.png');
    final image15 = await imageFromAssetBundle('image/B5.png');
    final image16 = await imageFromAssetBundle('image/B6.png');
    final image17 = await imageFromAssetBundle('image/B7.png');

    // String? _logo = await rootBundle.loadString('assets/r2.svg');

    doc.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(
          pageFormat: format.copyWith(
            height: height * 1.46,
            marginBottom: 0,
            marginLeft: 0,
            marginRight: 0,
            marginTop: 0,
          ),
          orientation: pw.PageOrientation.portrait,
          theme: pw.ThemeData.withFont(
            base: font1,
            bold: font2,
          ),
        ),
        build: (context) {
          return pw.Container(
              child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.SizedBox(height: 10),
              pw.Image(
                image1,
                height: height*0.57,
              ),
              pw.Divider(thickness: 5, color: PdfColors.blue900),
              pw.Image(
                image2,
                height: height * 0.23,
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.SizedBox(width: widtht * 0.06),
                  pw.Text(
                    'Recept No.  : $randomNumber',
                    style: pw.TextStyle(
                        font: font3, fontSize: 23, color: PdfColors.red700),
                  ),
                  pw.SizedBox(width: widtht * 0.50),
                  pw.Text(
                    'Date : $date',
                    style: pw.TextStyle(
                        font: font3, fontSize: 23, color: PdfColors.purple800),
                  ),
                ],
              ),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.SizedBox(width: widtht * 0.05),
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Image(
                        image11,
                        width: widtht * 0.45,
                      ),
                    ]),
                pw.SizedBox(width: widtht * 0.01),
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.SizedBox(height: height * 0.009),
                      pw.Text(
                        ' :   $donator',
                        style: pw.TextStyle(
                            font: font3,
                            fontSize: 29,
                            color: PdfColors.blue800),
                      ),
                    ]),
              ]),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.SizedBox(width: widtht * 0.05),
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Image(
                        image12,
                        width: widtht * 0.45,
                      ),
                    ]),
                pw.SizedBox(width: widtht * 0.01),
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.SizedBox(height: height * 0.01),
                      pw.Text(
                        ' :   $remember',
                        style: pw.TextStyle(
                            font: font3,
                            fontSize: 29,
                            color: PdfColors.blue800),
                      ),
                    ]),
              ]),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.SizedBox(width: widtht * 0.05),
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Image(
                        image13,
                        width: widtht * 0.45,
                      ),
                    ]),
                pw.SizedBox(width: widtht * 0.01),
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.SizedBox(height: height * 0.01),
                      pw.Text(
                        ' :   $date_of_tithi',
                        style: pw.TextStyle(
                          font: font3,
                          fontSize: 29,
                          color: PdfColors.blue800,
                        ),
                      ),
                    ]),
              ]),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.SizedBox(width: widtht * 0.05),
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Image(
                        image14,
                        width: widtht * 0.45,
                      ),
                    ]),
                pw.SizedBox(width: widtht * 0.01),
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.SizedBox(height: height * 0.01),
                      pw.Text(
                        ' :   $address',
                        style: pw.TextStyle(
                            font: font3,
                            fontSize: 29,
                            color: PdfColors.blue800),
                      ),
                    ]),
              ]),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.SizedBox(width: widtht * 0.05),
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Image(
                        image15,
                        width: widtht * 0.45,
                      ),
                    ]),
                pw.SizedBox(width: widtht * 0.01),
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.SizedBox(height: height * 0.01),
                      pw.Text(
                        ' :   $phone',
                        style: pw.TextStyle(
                            font: font3,
                            fontSize: 29,
                            color: PdfColors.blue800),
                      ),
                    ]),
              ]),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.SizedBox(width: widtht * 0.05),
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Image(
                        image16,
                        width: widtht * 0.45,
                      ),
                    ]),
                pw.SizedBox(width: widtht * 0.01),
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.SizedBox(height: height * 0.01),
                      pw.Text(
                        ' :   $donation',
                        style: pw.TextStyle(
                            font: font3,
                            fontSize: 29,
                            color: PdfColors.blue800),
                      ),
                    ]),
              ]),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.SizedBox(width: widtht * 0.05),
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.SizedBox(height: height * 0.01),
                      pw.Text(
                        '$donationInWord',
                        style: pw.TextStyle(
                            font: font3,
                            fontSize: 30,
                            color: PdfColors.blue800),
                      ),
                    ]),
              ]),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.SizedBox(width: widtht * 0.04),
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Image(image3, height: height * 0.045),
                    ]),
              ]),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
                pw.SizedBox(width: widtht * 0.05),
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Image(
                        image17,
                        width: widtht * 0.45,
                      ),
                    ]),
                pw.SizedBox(width: widtht * 0.01),
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.SizedBox(height: height * 0.01),
                      pw.Text(
                        ' :   $taker',
                        style: pw.TextStyle(
                            font: font3,
                            fontSize: 29,
                            color: PdfColors.blue800),
                      ),
                    ]),
              ]),
            ],
          ));
        },
      ),
    );
    return doc.save();
  }
}
