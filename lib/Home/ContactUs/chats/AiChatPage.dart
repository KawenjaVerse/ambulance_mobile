import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/Helper.dart';

class AiChatPage extends StatefulWidget{
  @override
  State<AiChatPage> createState() {
    return _AiChatPage();
  }

}

class _AiChatPage extends State<AiChatPage>{

  var _messageController = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  List<dynamic> responses = [];

  var _loading_message = false;

  var answer = "";
  var question = "";

  Future<void> sendMessage() async {
    var pref = await SharedPreferences.getInstance();
    var user_id = pref.getString("user_id");

    requestAPI("https://admin.egrow.life/api/ai/ask", {
      "cti_id":"TEST$user_id",
      "question":_messageController.text,
    }, (loading){
      setState(() {
        _loading_message = loading;
      });
    }, (value){
        setState(() {
          dynamic r = {
            "question": value["question"],
            "answer": value["answer"],
          };
          responses.add(r);
          _messageController.text = "";
        });
    }, (error){}, method: "POST");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ai Chat"),),
      body: Column(
        children: [

          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.brown
            ),
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 4),
                  child: Text("All information submitted here will be used for further analysis and improvement of our services.", style: TextStyle(color: Colors.white, fontSize: 10), textAlign: TextAlign.center,),
                ),
                Row(
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
              ],
            ),
          ),

          Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              child: Text("History (${responses.length})", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),

          Expanded(
            child: ListView.builder(
                      itemCount: responses.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Question: ${index+1}", style: TextStyle(fontSize: 12),),
                              Divider(),
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right:  8),
                                      width: 28,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        color: Colors.black45,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(Icons.person, size: 20, color: Colors.white,),
                                  ),
                                  Expanded(child: Text(responses[index]["question"])),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right:  8),
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.computer, size: 18, color: Colors.white,),
                                  ), Expanded(child: Text(responses[index]["answer"], style: TextStyle(fontWeight: FontWeight.bold),)),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
          ),

        ],
      ),
    );
  }
}