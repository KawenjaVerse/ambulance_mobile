import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'KnowledgePreviewPage.dart';

class KnowledgePage extends StatefulWidget{
  @override
  State<KnowledgePage> createState() {
    return _KnowledgePage();
  }

}

class _KnowledgePage extends State<KnowledgePage>{

  var resources = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tuberculosis"),),
      body: ListView.builder(
                itemCount: resources.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => KnowledgePreviewPage() ) );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                child: Image(image: AssetImage("assets/images/ecg.webp")),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black12,
                                  border: Border.all(color: Colors.black26, width: 1.5),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("New Tuberculosis Variant 2025",style: TextStyle(fontWeight: FontWeight.bold),),
                                      Text("This is a new variant of Tuberculosis that is expected to hit the world in 2025"),
                                    ],
                                  ),
                                ),
                              ),
                              Icon(Icons.chevron_right),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}