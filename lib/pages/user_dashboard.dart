import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kdgaugeview/kdgaugeview.dart';
import 'package:tokat/models/harm.dart';

class MyUserDashboard extends StatefulWidget {
   MyUserDashboard({super.key, required this.userInfo});
Map<String, dynamic> userInfo;
  @override
  State<MyUserDashboard> createState() => _MyUserDashboardState();
}

class _MyUserDashboardState extends State<MyUserDashboard> {
  List<Harm> myHarms = [
    Harm(icon: Icon(Icons.car_repair), name: "Araba", value: 15),
    Harm(icon: Icon(Icons.directions_walk), name: "Yürüyüş", value: -21.5),
    Harm(icon: Icon(Icons.fastfood), name: "Yiyecek", value: 24.6)
  ];

  final speedNotifier = ValueNotifier<double>(10);




  @override
  Widget build(BuildContext context) {
    double carbon=0;
    for(Harm i in myHarms){
      carbon += i.value;
    }
    return Center(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Hi, ${widget.userInfo["name"]}",
                style: TextStyle(fontSize: 38, color: Colors.white),
              ),
              Container(
                width: 400,
                height: 400,
                padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                child: ValueListenableBuilder<double>(
                    valueListenable: speedNotifier,
                    builder: (context, value, child) {
                      print(value);
                      return KdGaugeView(
                        minSpeed: 0,
                        maxSpeed: 100,
                        speed: carbon,
                        animate: false,
                        alertSpeedArray: [40, 80, 90],
                        alertColorArray: [
                          Colors.orange,
                          Colors.indigo,
                          Colors.red
                        ],
                        duration: Duration(seconds: 6),
                      );
                    }),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 8 / 9,
                height: MediaQuery.of(context).size.width * 2/5,
                child: Card(
                  child: ListView.builder(
                    itemCount: myHarms.length,
                    itemBuilder: (context, index) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            myHarms[index].icon,
                            Text(myHarms[index].name,style: TextStyle(fontSize: 34))
                          ],
                        ),
                        Row(
                          children: [
                            Text(myHarms[index].value.toString(),style: TextStyle(fontSize: 34),),
                            Text(myHarms[index].type.toString(),style: TextStyle(fontSize: 26)),
                          ],
                        ),

                      ],
                    ),
                  ),
                  color: Color.fromRGBO(79, 157, 133, 100),
                ),
              )
            ],

            // This trailing comma makes auto-formatting nicer for build methods.
          ),
        ));;
  }
}
