import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tokat/pages/home_page.dart';

class MyRegisterPage extends StatefulWidget {
  const MyRegisterPage({super.key});

  @override
  State<MyRegisterPage> createState() => _MyRegisterPageState();
}

class _MyRegisterPageState extends State<MyRegisterPage> {
  final textEditingControllerName =TextEditingController();
  final textEditingControllerUsername =TextEditingController();

  final textEditingControllerEmail =TextEditingController();
  final textEditingControllerPassword1 =TextEditingController();
  final textEditingControllerPassword2 =TextEditingController();


  Future<void> registerUser() async {
    String name=textEditingControllerName.text;
    String username=textEditingControllerUsername.text;
    String email=textEditingControllerEmail.text;
    String password1=textEditingControllerPassword1.text;
    String password2=textEditingControllerPassword2.text;
    try {
      if(password1!= password2){
        throw ArgumentError.notNull("Not equal passwords.");
      }
      // 1. FirebaseAuth ile yeni bir kullanıcı oluştur
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password1,
      );
      String userId = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'name': name,
        'username': username,
        'email': email,
      });

Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(),))    ;
    } catch (e) {
      print("Hata: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Image.asset("assets/pic/logo_agac.png"),
                    ),     Container(
                      child: Image.asset("assets/pic/logo.png"),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Text(
                  "Yeni Bir Hesap Oluştur",textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 36.0,color: Colors.green),
                ),
                TextField(
                  controller: textEditingControllerName,
                  decoration: InputDecoration(
                    labelText: 'İsim',
                    hintText: 'Hamza',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                ),
                TextField(
                  controller: textEditingControllerUsername,
                  decoration: InputDecoration(
                    labelText: 'Kullanıcı Adı',
                    hintText: 'hamza123',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                ),
                TextField(
                  controller: textEditingControllerEmail,
                  decoration: InputDecoration(
                    labelText: 'E-posta',
                    hintText: 'tokat@alanadi.com',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                ),
                TextField(obscureText: true,
                  controller: textEditingControllerPassword1,
                  decoration: InputDecoration(
                    labelText: 'Şifre',
                    hintText: '********',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                ),
                TextField(obscureText: true,
                  controller: textEditingControllerPassword2,
                  decoration: InputDecoration(
                    labelText: 'Şifre Tekrar',
                    hintText: '********',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color.fromRGBO(95,187,159,100)),
                        ),
                        onPressed: registerUser,
                        child: Text("Kaydol"),),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Zaten üye misiniz?"),
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text("Giriş Yap")),
                  ],
                )
              ],
            ),
          ),
        ),
      ),

    );
  }
}
