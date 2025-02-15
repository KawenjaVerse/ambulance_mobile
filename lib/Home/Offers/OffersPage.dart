import 'package:ambulance_app/Home/Offers/KnowledgePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OffersPage extends StatefulWidget{
  @override
  State<OffersPage> createState() {
    return _OffersPage();
  }

}

class _OffersPage extends State<OffersPage>{

  var picture_link = "https://images.ctfassets.net/pxcfulgsd9e2/4Xr55WGNYdIl0jJRSyvZNh/ec823e428ba388457f0df066097e1ca9/Tuberculosis_Facts_HN3270_iStock_1410735459_Sized.jpg?f=top&fit=fill&fl=progressive&fm=jpg&h=786&q=85&w=1396";
  var videos = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];
  var audios = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.book), text: "Knowledge"),
              Tab(icon: Icon(Icons.video_settings), text: "Videos",),
              Tab(icon: Icon(Icons.audiotrack_sharp), text: "Audio",),
            ],
          ),
          title: const Text('Offers'),
        ),
        body: TabBarView(
          children: [
            Container(
              child: Center(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                      //make height half of width
                      childAspectRatio: 0.7,
                    ),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => KnowledgePage() ) );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                            child: Column(
                              children: [
                                Expanded(child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      image: NetworkImage(picture_link),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ) ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Column(
                                    children: [
                                      Text("Tuberculosis",style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                      Text("23 Resources", style: TextStyle(color: Colors.grey, fontSize: 11),),
                                    ],
                                  ),
                                ),
                              ],),
                          ),
                        ),
                      );
                    }
                ),
              ),
            ),
            Container(child: ListView.builder(
                      itemCount: videos.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    height: 200,
                                    child: Center(child: Icon(Icons.play_circle, size: 60, color: Colors.white,)),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        image: NetworkImage(picture_link),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Text("Quick Tuberculosis Diagnosis Medication in the northern part of hilliness", style: TextStyle( fontSize: 15, fontWeight: FontWeight.bold),),
                                ),
                                SizedBox(height: 10,),
                              ],
                            ),
                          ),
                        );
                      },
                    ),),
            Container(child: ListView.builder(
                      itemCount: audios.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    height: 50, width: 50,
                                    child: Center(child: Icon(Icons.speaker_sharp, size: 30, color: Colors.white,)),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        image: NetworkImage(picture_link),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 1),
                                    child: Text("Quick Tuberculosis Diagnosis Medication in the northern part of hilliness", style: TextStyle( fontSize: 13, fontWeight: FontWeight.bold),),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Colors.black12,
                                      border: Border.all(color: Colors.black26, width: 1.5),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Icon(Icons.multitrack_audio,size: 15,)
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),),
          ],
        ),
      ),
    );
  }

}