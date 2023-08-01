
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_error/signup.dart';
import 'home.dart';

class chat extends StatelessWidget {

  //final email=FirebaseAuth.instance;
  var z=FirebaseAuth.instance.currentUser!.email;
  final messagecont=TextEditingController();
  late var a="";
  bool? b=false;
  var isme;


  final sendto ,message,Id;

  chat({required this .sendto,required this.message ,required this .Id});

  // String? get i => Id;
  // String? get s => sendto;
  CollectionReference user=FirebaseFirestore.instance.collection("chats");
  CollectionReference user1=FirebaseFirestore.instance.collection("chats").doc().collection("mess");

  // CollectionReference user1=FirebaseFirestore.instance.collection("chats").doc(i).collection("mess");

  // void messagestream() async{
  //   await for(var snapshot in user.snapshots()){
  //     for(var mess in snapshot.docs){
  //       print(mess.get("sendto"));
  //     }
  //   }
  // }
  // void getdata() async{
  //   var c= await user1.get();
  //   c.docs.forEach((element) {
  //     for(var mess in c.docs){
  //       print(mess.data());
  //     }
  //   });
  // }
  var time=DateTime.now();

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(resizeToAvoidBottomInset: false,
          bottomNavigationBar:  Row( mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: (){}, icon: Icon(Icons.keyboard)),
                Container( height: 40,width:320,alignment:Alignment.centerRight, margin:EdgeInsets.only(right: 10),
                  child:
                  TextFormField( controller: messagecont,
                    decoration: InputDecoration( suffixIcon:IconButton(
                        onPressed: ()async{
                          z=await FirebaseAuth.instance.currentUser!.email;
                          await FirebaseFirestore.instance.collection("chats").doc(Id).collection("mess").add({"text":"${messagecont.text}","gmail":z,"Time":DateTime.now()}).then((value) {
                            print("doneeeeee");
                          });
                          messagecont.clear();
                        },
                        icon: Icon(Icons.send)
                    ) ,focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.blue, width: 3)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          gapPadding: 50,
                          borderSide:BorderSide(color: Colors.grey)),),),
                ),]
          ),
          appBar: AppBar(
              title:Text('${sendto}')
            ,leading: IconButton(onPressed: (){
              Navigator.of(context).pushNamed("home");
          }, icon:Icon(Icons.arrow_back_outlined)),
              actions:[Row(
                mainAxisAlignment:MainAxisAlignment.start,
                children: [
                IconButton(onPressed: (){
                  print("--------------------------");
                  // messagestream();
                }, icon:Icon(Icons.videocam)),
                IconButton(onPressed: ()async{
                  // messagestream();
                  print("-----dd----------");
                  print(sendto);
                  print(message.toString());
                  print(time);
                  print(DateTime.now());
                  print(Id);
                  //  await FirebaseFirestore.instance.collection("chats").doc(Id).collection("mess");

                }, icon:Icon(Icons.call)),
              ],),]
          ),
          body:
          SafeArea(
            child: Column(
              children: [
                //Container(),
                StreamBuilder(
                  stream: user.doc(Id).collection("mess").orderBy("Time").snapshots(),builder: (context, snapshot) {
                  List<messstyle>messageT=[];
                  for(var message in snapshot.data!.docs) {
                    final messageget=message.get("text");
                    final currentacc=message.get("gmail");
                    var c=FirebaseAuth.instance.currentUser!.email;

                    final messagew=Text("$messageget");
                    messageT.add(messstyle(text: messageget,sender:currentacc,isme:currentacc==c));
                   // messageT.add(messagew);
                  }
                    return Expanded(
                      child: SizedBox(
                        child:
                        InkWell(onLongPress:()async{
                          //await user.doc(snapshot.data!.docs[i].id).collection("mess").doc().delete();
                        } ,
                          child: ListView(reverse:false,
                          children:
                          messageT
                  ),
                        ),
                      ),
                    );
                },)
              ],
            ),
          )
      );
  }
}


class messstyle extends StatelessWidget {
 final String? text,sender;
  final bool isme;
  messstyle({required this.text,required this.sender,required this.isme});
  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment:isme? CrossAxisAlignment.end:CrossAxisAlignment.start,
          children: [
            Text(sender!,style: TextStyle(color: Colors.orange),),
            Padding(padding: EdgeInsetsDirectional.all(1)),
            InkWell( onLongPress: (){
              showDialog(context: context, builder:(context) {
                return AlertDialog(
                    shape:UnderlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    //OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                title: Text("Delete Message ?",textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                actions:[
                        Column(
                     children:[
                       Text("This message will be deleted for you and other people",style: TextStyle(fontSize: 18),textAlign:TextAlign.center),
                       Padding(padding: EdgeInsetsDirectional.all(5)),
                       Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                         children: [
                           Container( margin:EdgeInsetsDirectional.only(top: 10,end: 5),child: ElevatedButton(
                               onPressed: (){
                                 Navigator.pop(context);
                               },
                               child:Text("Cancel",textAlign: TextAlign.center,style: TextStyle(fontSize: 20),))),


                           Container( margin:EdgeInsetsDirectional.only(top: 10,end: 5),child: ElevatedButton(
                               onPressed: () async{

                               },
                               child:Text("Delete",textAlign: TextAlign.center,style: TextStyle(fontSize: 20),))),
                         ],)],
                        ),
                      ]
              );
            },);},
              child: Material(
                color: isme?Colors.teal:Colors.cyan,
                borderRadius:isme?
                BorderRadiusDirectional.only(
                  topEnd: Radius.circular(1),topStart:Radius.circular(25),bottomEnd: Radius.circular(15),bottomStart: Radius.circular(25) ):
                BorderRadiusDirectional.only(
              topEnd: Radius.circular(25),topStart:Radius.circular(1),bottomEnd: Radius.circular(25),bottomStart: Radius.circular(15) )
                ,
                //   shape:
                // OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("$text",style: TextStyle(fontSize: 20,color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      );
  }}