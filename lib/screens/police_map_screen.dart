// ignore_for_file: prefer_const_constructors, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const Color1 = Color(0xff555692);
const Color2 = Color(0xff8587DC);
const Color3 = Color(0xffACADFF);
const Color4 = Color(0xffa1a4d5);

class PoliceMapScreen extends StatefulWidget {
  const PoliceMapScreen({Key? key}) : super(key: key);

  @override
  State<PoliceMapScreen> createState() => _PoliceMapScreenState();
}

class _PoliceMapScreenState extends State<PoliceMapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color1,
        title: Text('Near-By Police'),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition:
            CameraPosition(target: LatLng(12.8171374, 80.0407372), zoom: 18),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
        },
        tooltip: 'Google Map',
        child: Icon(Icons.pin_drop_outlined),
        backgroundColor: Color2,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
