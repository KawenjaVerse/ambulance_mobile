import 'package:ambulance_app/Home/ContactUs/chats/ChatPeoplePage.dart';
import 'package:ambulance_app/utils/Helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'chats/AiChatPage.dart';
import 'chats/ChatPage.dart';

class ContactUsPage extends StatefulWidget{
  @override
  State<ContactUsPage> createState() {
    return _ContactUsPage();
  }

}

class _ContactUsPage extends State<ContactUsPage>{

  var contacts = [1,2,3,2,3,2,3,2,3,2,3];
  var actions = [];

  @override
  void initState() {
    super.initState();
    actions = [
      {"name":"AI Support ", "icon":Icons.computer, "subtitle":"Responses Instantly", "color":Colors.brown, "id":0},
      {"name":"Call", "icon":Icons.call, "subtitle":"Call us now", "color":Colors.green, "id":1},
      {"name":"SMS", "icon":Icons.sms, "subtitle":"Send us a message", "color":Colors.blue, "id":2},
      {"name":"Chat", "icon":Icons.chat, "subtitle":"Chat with us", "color":Colors.orange, "id":3 },
      {"name":"Video Call", "icon":Icons.video_call, "subtitle":"Zoom Workspace" , "color":Colors.red, "id":4 },
    ];
    getSocialMedia();
    getUser();
  }



  var social_media = [];
  bool _loading = false;
  getSocialMedia() {
    requestAPI("social_media", {"":""}, (loading){ setState(() {
      _loading = loading;
    }); }, (value){
      setState(() {
        social_media = value;
      });
    }, (error){}, method: "POST");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contact Us"),),
      body: Column(children: [



        Container(
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: actions.length,
            itemBuilder: (context, index){
              return GestureDetector(
                onTap: (){
                  if( actions[index]["id"] == 3 )
                   Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(reciever_id: "0",) ) );
                  else if( actions[index]["id"] == 0 )
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AiChatPage() ) );
                  else if( actions[index]["id"] == 1 )
                    launchURL("tel:+254712345678");
                  else if( actions[index]["id"] == 2 )
                    launchURL("sms:+254712345678");
                  else if( actions[index]["id"] == 4 ){
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => JoinScreen() ) );
                    //launchURL("https://zoom.us/j/1234567890");
                  }

                },
                child: Container(
                  width: 150,

                  margin: EdgeInsets.only(left: 5),
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: actions[index]["color"] ,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(actions[index]["icon"], size: 20, color: Colors.white,)),
                                SizedBox(height: 5,),
                                Text(actions[index]["name"], style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10),)
                          ),
                            padding: EdgeInsets.symmetric(vertical: 8),
                            width: double.infinity,
                            child: Text(actions[index]["subtitle"], style: TextStyle(fontSize: 11, color: Colors.white),textAlign: TextAlign.center,)),
                      ],
                    ),
                  ),
                ),
              );
            }
          ),
        ),


        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: const EdgeInsets.only(left: 15),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            children: [
              Text("Customer Support Dashboard", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
              Spacer(),
              IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPeoplePage() ) );
              })
            ],
          ),
        ),

        //2 by varing grid
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text("Social Media", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              image: DecorationImage(
                image: AssetImage("assets/images/diaspora.jpeg"),
                fit: BoxFit.cover
              )
            ),

            child: _loading ? Center(child: CircularProgressIndicator()) :
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: social_media.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 2.9
                ),
                itemBuilder: (context, index){
                  var sm = social_media[index];
                  return GestureDetector(
                    onTap: (){
                      launchURLLink(sm["link"]);
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(sm["picture"]),
                                        fit: BoxFit.cover
                                    )
                                )),
                            SizedBox(width: 10,),
                            Text("${sm["name"]}", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              ),
            ),
          ),
        )

      ],),
    );
  }

  Future<void> launchURLLink(String sm_link) async {
    if( sm_link.startsWith("http") ) {
      var url = Uri.parse(sm_link);
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $sm_link');
      }
    }
  }
  Future<void> launchURL(String sm_link) async {
      var url = Uri.parse(sm_link);
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $sm_link');
      }
  }

  //user_type
  var user_type = "user";
  Future<void> getUser() async {
    var pref = await SharedPreferences.getInstance();
    setState(() {
      user_type = pref.getString("user_type") ?? "user";
    });
  }


}