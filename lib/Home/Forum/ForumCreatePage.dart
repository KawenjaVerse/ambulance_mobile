import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/Helper.dart';

class ForumCreatePage extends StatefulWidget{
  @override
  State<ForumCreatePage> createState() {
    return _ForumCreatePage();
  }

}

class _ForumCreatePage extends State<ForumCreatePage>{

  var _formKey = GlobalKey<FormState>();

  var typeMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Post"),),
      body: Column(
        children: [

          Expanded(child: Container(
            child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Container(
                        height: 100,
                        margin: EdgeInsets.all(smallMargin),
                        decoration: boxDecoration,
                        width: double.infinity,
                        child: TextFormField(

                          maxLines: 5,
                          decoration: inputDecoration("Type your message"),
                          onSaved: (value){
                            typeMessage = value!;
                          },
                        ),
                      ),
                    ),
                  ),
          )),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(children: [

              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  padding: EdgeInsets.symmetric(vertical: 9),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    border: Border.all(color: Colors.black26, width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,children: [
                    Icon(Icons.video_library_sharp,size: 15,),
                    SizedBox(width: 5,),
                    Text("Add Video",style: TextStyle( fontSize: 12),),
                  ],),
                ),
              ),

              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  padding: EdgeInsets.symmetric(vertical: 9),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    border: Border.all(color: Colors.black26, width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,children: [
                    Icon(Icons.photo,size: 15,),
                    SizedBox(width: 5,),
                    Text("Add Photo",style: TextStyle( fontSize: 12),),
                  ],),
                ),
              ),

              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  padding: EdgeInsets.symmetric(vertical: 9),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    border: Border.all(color: Colors.black26, width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    Icon(Icons.mic,size: 15,),
                    SizedBox(width: 5,),
                    Text("Add Audio",style: TextStyle( fontSize: 12),),
                  ],),
                ),
              ),


            ],),
          ),

          GestureDetector(
            onTap: (){

            },
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 5, right: 5, bottom: 5),
              child: Card(
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(child: Text("Post message", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)),
                      Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            border: Border.all(color: Colors.white, width: 1.5),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Icon(Icons.send,size: 15,color: Colors.white,)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}