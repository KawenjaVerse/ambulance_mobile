import 'package:ambulance_app/Home/Forum/ForumCreatePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForumPage extends StatefulWidget{
  @override
  State<ForumPage> createState() {
    return _ForumPage();
  }

}

class _ForumPage extends State<ForumPage>{

  var messages = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Forum"),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => ForumCreatePage() ) );
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 5, right: 5, bottom: 5),
                child: Card(
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(child: Text("Add a new message", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)),
                        Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              border: Border.all(color: Colors.white, width: 1.5),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Icon(Icons.add,size: 15,color: Colors.white,)),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 10),
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage("assets/images/doctor.jpg"),
                                              fit: BoxFit.cover,
                                            ),
                                            color: Colors.black12,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Isaac Ronald", style: TextStyle(fontWeight: FontWeight.bold),),
                                            Text("3days ago", style: TextStyle(fontSize: 12, color: Colors.grey),),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10.0),
                                    child: Text("Any new messages from the app users asking the doctors a question about something they are going through",style: TextStyle( fontSize: 12),),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage("assets/images/sick-person-doctor.jpg"),
                                        fit: BoxFit.cover,
                                      ),
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    height: 150,
                                    width: double.infinity,
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    padding: EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Dr. Medina", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 12),),
                                        Text("Doctors are advised to respond to the messages as soon as possible to avoid any inconveniences to the users",style: TextStyle( fontSize: 12),),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color: Colors.black12,
                                            border: Border.all(color: Colors.black26, width: 1.5),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: Icon(Icons.bookmark_border,size: 15,)),

                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        padding: EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: Colors.black12,
                                          border: Border.all(color: Colors.black26, width: 1.5),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Row(children: [
                                          Icon(Icons.chat_bubble_outline_outlined,size: 15,),
                                          SizedBox(width: 5,),
                                          Text("Add Response",style: TextStyle( fontSize: 12),),
                                        ],),
                                      ),

                                      Expanded(child: Text("+300 likes", textAlign: TextAlign.end, style: TextStyle(fontSize: 12),)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
          ],
        ),
      ),
    );
  }
}