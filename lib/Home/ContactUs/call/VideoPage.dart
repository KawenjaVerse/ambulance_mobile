import 'package:ambulance_app/Home/ContactUs/call/api_call.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var AUTO_GENERATED_TOKEN = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiIzYzVhZmNjMy05ZTFlLTRiZjItYTJmMC1mYTVkYjFlN2RiODUiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTczNTY5MDc2MCwiZXhwIjoxNzM2Mjk1NTYwfQ.ktj3evO2MM3R4DhsELcoY4yzuJRD-jy8HyYqJj03HFg";

class VideoPage extends StatefulWidget{
  @override
  State<VideoPage> createState() {
    return _VideoPage();
  }

}

class _VideoPage extends State<VideoPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("VideoPage"),),
      body: Column(
        children: [
          GestureDetector(
            onTap: (){
              startMeeting();
            },
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.brown,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Text("Start"),
            ),
          ),
        ],
      ),
    );
  }

  void startMeeting() {
    createMeeting().then((roomId) {
      print("RoomId: $roomId");
    });
  }
}