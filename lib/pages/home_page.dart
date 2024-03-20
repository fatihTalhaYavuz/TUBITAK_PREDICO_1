import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kdgaugeview/kdgaugeview.dart';
import 'package:tokat/models/harm.dart';
import 'package:tokat/pages/map_page.dart';
import 'package:tokat/pages/user_dashboard.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final key = GlobalKey<KdGaugeViewState>();
  User? user;

  Map<String, dynamic> userInfo = {};

  Future<void> init() async {
    String uid = user!.uid;
    userInfo =  (await FirebaseFirestore.instance.collection("users").doc(uid).get())
        .data() ??
        {};
    setState(() {});
  }
  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    init();
    super.initState();
  }


  int navIndex =0;

  void changePage(int index){
    navIndex = index;
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {


    Widget pages(){
      if(navIndex == 0){
        return MyMapPage();
      }else{
        return MyUserDashboard(userInfo: userInfo,);
      }
    }
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0,title: Text("PREDICO2",style:TextStyle(color: Colors.grey,fontSize: 28)),centerTitle: true,),
        backgroundColor: Color.fromRGBO(95, 187, 159, 100),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: navIndex,
            onTap: (index){
              changePage(index);
            },
            items: [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Harita"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Ana Sayfa"),
        ]),
        body:pages() );
  }
}
