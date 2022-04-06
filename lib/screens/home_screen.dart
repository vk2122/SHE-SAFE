// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_authentication_demo/model/user_model.dart';
import 'package:flutter_firebase_authentication_demo/screens/contact_select_screen.dart';
import 'package:flutter_firebase_authentication_demo/screens/login_screen.dart';
import 'package:flutter_firebase_authentication_demo/screens/police_map_screen.dart';
import 'package:flutter_firebase_authentication_demo/screens/progress.dart';

const Color1 = const Color(0xff555692);
const Color2 = const Color(0xff8587DC);
const Color3 = const Color(0xffACADFF);
const Color4 = const Color(0xffa1a4d5);

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0 : ChatBox',
      style: optionStyle,
    ),
    Text(
      'Index 1 : Home',
      style: optionStyle,
    ),
    Text(
      'Index 2 : Settings',
      style: optionStyle,
    ),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    //logout button
    final logoutButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color1,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width / 2,
        onPressed: () {
          logout(context);
        },
        child: Text(
          "Logout",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    List<Widget> homedata = <Widget>[];
    homedata.add(Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.fill)),
      child: Center(
        child: Text('Chat Box Page'),
      ),
    ));
    homedata.add(Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/profileback.png'),
              fit: BoxFit.fill)),
      child: Center(
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Center(
                    child: IconButton(
                      iconSize: width / 2.5,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PoliceMapScreen()),
                        );
                      },
                      icon: Image.asset("assets/images/policebutton.png"),
                    ),
                  ),
                  Center(
                    child: IconButton(
                      iconSize: width / 2.5,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContactSelectScreen()),
                        );
                      },
                      icon: Image.asset("assets/images/sosbutton.png"),
                    ),
                  ),
                  Center(
                    child: IconButton(
                      iconSize: width / 2.5,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UnderProgress()),
                        );
                      },
                      icon: Image.asset("assets/images/ambulancebutton.png"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    )
        /*Center(
      child: Padding(
        padding: EdgeInsets.all(36),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 150,
              child: Image.asset(
                "assets/logo.png",
                fit: BoxFit.contain,
              ),
            ),
            Text(
              "Welcome Back",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "${loggedInUser.name} ${loggedInUser.phone}",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "${loggedInUser.email}",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            ActionChip(
                label: Text("Logout"),
                onPressed: () {
                  logout(context);
                }),
          ],
        ),
      ),
    )*/
        );
    homedata.add(
      Container(
        //padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/profileback.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
                child: CircleAvatar(
                    radius: (80),
                    backgroundColor: Color1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset("assets/images/profile1.png"),
                    ))),
            SizedBox(
              height: 35,
            ),
            Container(
              height: MediaQuery.of(context).size.height/4,
              padding: EdgeInsets.only(left: 50, right: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    height: 45,
                    //width: MediaQuery.of(context).size.width/3,
                    decoration: BoxDecoration(
                      color: Color3,
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.person, color: Colors.white,),
                        SizedBox(width: 20,),
                        Text("${loggedInUser.name}", style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                        ),)
                      ],
                    ),
                  ),
                  //SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    height: 45,
                    //width: MediaQuery.of(context).size.width/3,
                    decoration: BoxDecoration(
                      color: Color3,
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.phone, color: Colors.white,),
                        SizedBox(width: 20,),
                        Text("+91 ${loggedInUser.phone}", style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                        ),)
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    height: 45,
                    //width: MediaQuery.of(context).size.width/3,
                    decoration: BoxDecoration(
                      color: Color3,
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.mail, color: Colors.white,),
                        SizedBox(width: 20,),
                        Text("${loggedInUser.email}", style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                        ),)
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    height: 45,
                    //width: MediaQuery.of(context).size.width/3,
                    decoration: BoxDecoration(
                      color: Color3,
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(Icons.bloodtype, color: Colors.white,),
                        SizedBox(width: 20,),
                        Text("A/B/AB/O", style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                        ),)
                      ],
                    ),
                  ),
                ],
              )
            ),
            SizedBox(
              height: 55,
            ),
            logoutButton
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color1,
        title: Text("SHE-SAFE"),
        centerTitle: true,
      ),
      body: homedata.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color1,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'ChatBox',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
