import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:ui';

import 'package:cloud_error/signup.dart';
import 'package:cloud_error/chat.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'home.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),routes:{
      "signup":(context)=>signup(),
      //"signin":(context)=>signin(),
      "home":(context)=>home(sendto: "sendto",sendto2: "sendto2"),
     "chat":(context)=>chat(sendto:"sendto",message: "message",Id: "id",),
      "MyHomePage":(context)=>MyHomePage(title: '',),
    },
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var email,pass;
  var showpass=true;
  final auth=FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      //  FirebaseFirestore.instance.disableNetwork();
      FirebaseAuth.instance;
      print("/////////////////////////////////////");
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
        // Here we take the value fr
      body:
      Center(
          child:Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(margin:EdgeInsets.all(10),child:
              Text("welcome babe to my app ",style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),


              Container( margin:EdgeInsets.all(30),child:
              Text("Sign in ",style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),

              Container( alignment: Alignment.centerLeft,margin: EdgeInsets.only(left: 10,),
                  child: Text("Email",style:TextStyle(fontSize: 20),)),


              Container( margin: EdgeInsets.all(8),
                  child: TextFormField(onChanged: (value) => email=value,cursorColor: Colors.indigo,
                      decoration:InputDecoration(border: OutlineInputBorder(borderRadius:BorderRadius.circular(20)),
                        hintText: "Enter your email",
                      ))),

              Container( alignment: Alignment.centerLeft,margin: EdgeInsets.only(left: 10,),
                  child: Text("Password",style:TextStyle(fontSize: 20),)),


              Container( margin: EdgeInsets.all(8),
                  child: TextFormField(onChanged: (value) => pass=value,cursorColor: Colors.indigo,obscureText:showpass,
                      decoration:InputDecoration(suffixIcon: IconButton(onPressed: () async{

                        //                   var x= await Firebase.app().options;
                        //                   var c=await FirebaseFirestore.instance.collection("chats");
                        //                   try{
                        //                      await c.snapshots().listen((value) {
                        //               value.docs.forEach((element) {
                        //                   print("-------------");
                        //                            print(element.data());
                        // });
                        //
                        // });
                        // }catch(e){print("ERORRRRR:$e");}
                        //                 //  print(x);
                        //                   setState(() {
                        //                   showpass=false;});
                      }, icon:Icon(Icons.password)),border: OutlineInputBorder(borderRadius:BorderRadius.circular(20)),
                        hintText: "Enter your Password",
                      ))),

              ElevatedButton(onPressed:() async {
               var user=await auth.signInWithEmailAndPassword(email: email, password: pass);
                try {
                  final credential = await auth.signInWithEmailAndPassword(email: email, password: pass);
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    print('No user found for that email.');
                  } else if (e.code == 'wrong-password') {
                    print('Wrong password provided for that user.');
                    }}
                  print("-------------");
                print("email: "+"$email");
                print("pass: "+"$pass");
                if(user!=null){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => home(sendto:null,sendto2:null),));
                }
              }
                  ,child:Text("Sign in")
                  ),
              Row( mainAxisAlignment:MainAxisAlignment.center,children: [Text("Don't have an account?"),
                TextButton(onPressed: ()async {
                  print("u dont have acc");
                   Navigator.of(context).pushNamed("signup");
                },
                    child: Text("Sign up",style:TextStyle(fontWeight: FontWeight.bold),))],),

            ],
          )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
