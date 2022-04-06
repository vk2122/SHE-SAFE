// ignore_for_file: prefer_const_constructors, unused_import, import_of_legacy_library_into_null_safe, constant_identifier_names, unnecessary_const

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_picker/contact_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_authentication_demo/model/user_model.dart';
import 'package:flutter_firebase_authentication_demo/screens/home_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:location/location.dart';

const Color1 = const Color(0xff555692);
const Color2 = const Color(0xff8587DC);
const Color3 = const Color(0xffACADFF);
const Color4 = const Color(0xffa1a4d5);

class ContactSelectScreen extends StatefulWidget {
  const ContactSelectScreen({Key? key}) : super(key: key);

  @override
  State<ContactSelectScreen> createState() => _ContactSelectScreenState();
}

class _ContactSelectScreenState extends State<ContactSelectScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  late TwilioFlutter twilioFlutter;
  List number = [];

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
    twilioFlutter = TwilioFlutter(
        accountSid: 'AC1a6edb90be31920837dbd73344194bcd',
        authToken: '626218bde1b3be33a03e25f423d582f1',
        twilioNumber: '+18595175577');
    super.initState();
  }

  void sendSms(String number, String Location) async {
    twilioFlutter.sendSMS(
        toNumber: number,
        messageBody:
            '${loggedInUser.name} generated a DISTRESS ALERT.' + Location);
  }

  void getSms() async {
    var data = await twilioFlutter.getSmsList();
    print(data);
    await twilioFlutter.getSMS('***************************');
  }

  final TextEditingController contactController1 = new TextEditingController();
  final TextEditingController contactController2 = new TextEditingController();
  final TextEditingController contactController3 = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ContactPicker contactPicker1 = new ContactPicker();
    final ContactPicker contactPicker2 = new ContactPicker();
    final ContactPicker contactPicker3 = new ContactPicker();
    late Contact contact1;
    late Contact contact2;
    late Contact contact3;

    final contactSelect1 = TextFormField(
        //obscureText: true,
        autofocus: false,
        controller: contactController1,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Enter Contact Phone';
          }
        },
        onSaved: (value) {
          contactController1.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.contact_phone),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Phone Number",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          suffixIcon: IconButton(
            onPressed: () async {
              Contact contact = await contactPicker1.selectContact();
              setState(() {
                contact1 = contact;
                contactController1.text = contact1.fullName +
                    '  ' +
                    '(' +
                    contact1.phoneNumber.number +
                    ')';
                number.add(contact1.phoneNumber.number);
              });
            },
            icon: Icon(Icons.add_circle),
          ),
        ));
    final contactSelect2 = TextFormField(
        //obscureText: true,
        autofocus: false,
        controller: contactController2,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Enter Contact Phone';
          }
        },
        onSaved: (value) {
          contactController2.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.contact_phone),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Phone Number",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          suffixIcon: IconButton(
            onPressed: () async {
              Contact contact = await contactPicker2.selectContact();
              setState(() {
                contact2 = contact;
                contactController2.text = contact2.fullName +
                    '  ' +
                    '(' +
                    contact2.phoneNumber.number +
                    ')';
                number.add(contact2.phoneNumber.number);
              });
            },
            icon: Icon(Icons.add_circle),
          ),
        ));
    final contactSelect3 = TextFormField(
        //obscureText: true,
        autofocus: false,
        controller: contactController3,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Enter Contact Phone';
          }
        },
        onSaved: (value) {
          contactController3.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.contact_phone),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Phone Number",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          suffixIcon: IconButton(
            onPressed: () async {
              Contact contact = await contactPicker3.selectContact();
              setState(() {
                contact3 = contact;
                contactController3.text = contact3.fullName +
                    '  ' +
                    '(' +
                    contact3.phoneNumber.number +
                    ')';
                number.add(contact3.phoneNumber.number);
              });
            },
            icon: Icon(Icons.add_circle),
          ),
        ));

    //contact button
    final contactButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color1,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width / 2,
        onPressed: () {
          Navigator.of(context).pop();
          print(number);
          print('${loggedInUser.name}');
          //sendSms();
          for (int i = 0; i < number.length; i++) {
            sendSms(number[i].toString(), '12.8166245,80.0393164');
          }
          Fluttertoast.showToast(msg: "Emergency SOS SMS Sent");
          //Fluttertoast.showToast(msg: "Emergency Contact Details Added");
        },
        child: Text(
          "Proceed",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color1,
        title: Text("Contact Picker"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/forgotback.png"),
            fit: BoxFit.fill,
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            contactSelect1,
            Padding(padding: EdgeInsets.all(10)),
            contactSelect2,
            Padding(padding: EdgeInsets.all(10)),
            contactSelect3,
            Padding(padding: EdgeInsets.all(30)),
            contactButton
          ],
        ),
      ),
    );
  }
}
