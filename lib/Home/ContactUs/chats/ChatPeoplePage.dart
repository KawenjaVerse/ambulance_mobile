import 'package:ambulance_app/Home/ContactUs/chats/ChatPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/Helper.dart';
import '../call/VideoPage.dart';
import '../call/join_screen.dart';
import '../call/meeting_screen.dart';

class ChatPeoplePage extends StatefulWidget{
  @override
  State<ChatPeoplePage> createState() {
    return _ChatPeoplePage();
  }

}

class _ChatPeoplePage extends State<ChatPeoplePage>{

  @override
  void initState() {
    super.initState();
    getPeople();
  }

  var people = [];
  var _loading = false;
  getPeople() {
    requestAPI("chats_people", {
      "":""
    }, (loading){
      setState(() {
        _loading = loading;
      });
    }, (value){
      setState(() {
        people = value;
      });
    }, (error){},method: "POST");
  }


  var _loading_server = false;
  initiateVideoCall( call ) async {
    var pref = await SharedPreferences.getInstance();
    var user_id = pref.getString("user_id") ?? "0";

    requestAPI("calls/update", {
      "call_id":call["id"],
      "responder_id":user_id,
      "status":"attended",
    }, (loading){
      setState(() {
        _loading_server = loading;
      });
    }, (value){
      if(value["status"] == "success"){
        Navigator.push(context, MaterialPageRoute(builder: (context) => MeetingScreen(
          meetingId: call["meeting_id"],
          token: AUTO_GENERATED_TOKEN,
        ) ) );
      }
    }, (error){

    },method: "POST");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("People"),),
      body: _loading ? Center(child: CircularProgressIndicator()) : Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: people.length,
          itemBuilder: (context, index) {
            var person = people[index];
            return Container(
              padding: const EdgeInsets.all(2),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(child: Text("${person["name"]}", style: TextStyle(fontWeight: FontWeight.bold),)),
                                Text("${person["type"]}", style: TextStyle(fontSize: 12),)
                              ],
                            ),
                            Divider(height: 3,),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${person["email"]}",style: TextStyle(fontSize: 12),),
                                      Text("${person["phone"]}",style: TextStyle(fontSize: 12),),
                                    ],
                                  ),
                                ),

                              ],
                            ),


                            if( person["last_call"] != null )
                            GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.video_call, color: Colors.green,),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text("Call", style: TextStyle(color: Colors.green),),
                                    ),
                                    Expanded(child: Text("${person["last_call"]["status"]} at ${formatLaravelTime(person["last_call"]["created_at"])}", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),)),
                                    Icon(Icons.chevron_right, color: Colors.black,),
                                  ],
                                ),
                              ),
                              onTap: (){
                                initiateVideoCall(person["last_call"]);
                              },
                            ),
                            if( person["last_chat"] != null )
                            GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.chat, color: Colors.red,),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                      child: Text("Msg:", style: TextStyle(color: Colors.red),),
                                    ),
                                    Expanded(child: Text("${person["last_chat"]["message"]}", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),)),
                                    Icon(Icons.chevron_right, color: Colors.black,),
                                  ],
                                ),
                              ),
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(reciever_id:"${person["id"]}") ) );
                              },
                            )

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ) ;
          },
        ),
      ),
    );
  }
}