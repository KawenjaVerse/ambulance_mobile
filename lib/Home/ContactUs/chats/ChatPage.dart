import 'dart:io';
import 'package:ambulance_app/utils/Helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class ChatPage extends StatefulWidget{

  var reciever_id = "0";
  ChatPage({required this.reciever_id});

  @override
  State<ChatPage> createState() {
    return _ChatPage(reciever_id:reciever_id);
  }

}

class _ChatPage extends State<ChatPage>{

  var reciever_id = "0";
  _ChatPage({required this.reciever_id});

  var chats = [];

  @override
  void initState() {
    super.initState();
    getChats();
  }

  String? user_id = "";

  var _loading_chats = false;
  getChats() async {
    var pref = await SharedPreferences.getInstance();
    user_id = pref.getString("user_id");
    if( reciever_id != "0"){
      user_id = "0";
    }

    requestAPI("chats/get", {
      "sender_id":user_id,
      "receiver_id":reciever_id,
    }, (loading){
      setState(() {
        _loading_chats = loading;
      });
    }, (value){
      setState(() {
        chats = value;
      });
    }, (error){});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat With Support"),),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: _loading_chats ? Center(child: CircularProgressIndicator()) : ListView.builder(
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  var chat = chats[index];
                  var am_sender = user_id == "${chat["sender_id"]}";
                  var picture = chat["picture"];
                  var message = chat["message"];

                  return Container(
                      margin: EdgeInsets.only(left: am_sender ? 50 : 0, right: am_sender ? 0 : 50, top: 3, bottom: 3),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: am_sender ? Colors.blue : Colors.black12
                      ),
                      child: Column(
                        crossAxisAlignment: am_sender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [

                          if( message != "" && message != null && message != "null" )
                          Text("${ chat["message"] }", style: TextStyle(fontWeight: FontWeight.bold),),

                          if( picture != "" && picture != null && picture != "null" )
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 3),
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                  image: NetworkImage(requestFile("$picture")),
                                  fit: BoxFit.cover
                                )
                            ),
                          ),
                          Text("${formatLaravelTime(chat["created_at"])}", style: TextStyle(fontSize: 10),),
                        ],
                      ));
                },
              ),
            ),
          ),
          Container(
            width: double.infinity,

            decoration: BoxDecoration(
                color: Colors.blue
            ),
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [

                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            //pick image
                            pickPicture();
                          },
                          child: Container(
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.black45,
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              width: 38,
                              height: 38,
                              child: Icon(Icons.camera_alt_outlined, color: Colors.white,)),
                        ),
                        Expanded(
                          child: Form(
                            key: _formKey,
                            child: TextField(
                              controller: _messageController,
                              decoration: InputDecoration(
                                  hintText: "Type a message",
                                  hintStyle: TextStyle(color: Colors.black45),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 8)
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                if( _loading_message )
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2,),
                  ),

                GestureDetector(
                  onTap: (){
                    //send message
                    _formKey.currentState!.save();
                    sendMessage();
                  },
                  child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)
                      ),
                      width: 42,
                      height: 42,
                      child: Icon(Icons.send)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  var _formKey = GlobalKey<FormState>();
  var _messageController = TextEditingController();

  var _picture = "";
  pickPicture(){
    artyTechPickPicture(context, (path){
      _picture = path;
      sendMessage();
    });
  }


  var _loading_message = false;
  Future<void> sendMessage() async {
    var pref = await SharedPreferences.getInstance();
    var user_id = pref.getString("user_id");

    if( reciever_id != "0"){
      user_id = "0";
    }

    requestAPI("chats/send", {
      "sender_id":user_id,
      "receiver_id":reciever_id,
      "message":_messageController.text,
      if (_picture != "" && _picture != "null")
        'picture': await MultipartFile.fromFile(_picture, filename: "picture.jpg"),
    }, (loading){
      setState(() {
        _loading_message = loading;
      });
    }, (value){
      if( value["status"] == "success" ){
        _messageController.text = "";
        _picture = "";
        getChats();
      }
    }, (error){}, method: "POST");
  }
}