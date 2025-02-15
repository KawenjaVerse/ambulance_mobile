import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget{
  @override
  State<NotificationPage> createState() {
    return _NotificationPage();
  }

}

class _NotificationPage extends State<NotificationPage>{

  var messages = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notification"),),
      body: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(3),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                                margin: EdgeInsets.only(right: 10),
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  border: Border.all(color: Colors.black26, width: 1.5),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Icon(Icons.notifications,size: 15,)
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Disease Alert", style: TextStyle(fontWeight: FontWeight.bold),),
                                  Text("Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia"),
                                  Text("3 mins ago", style: TextStyle(color: Colors.grey, fontSize: 12),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}