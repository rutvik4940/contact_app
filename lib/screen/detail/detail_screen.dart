

import 'package:contact_app/model/model.dart';
import 'package:contact_app/utils/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  DataModel? data=DataModel(name: '', mobile: '', email: '', image: '');
  TextEditingController txtname = TextEditingController();
  TextEditingController txtmoblie = TextEditingController();
  TextEditingController txtemail = TextEditingController();
  // String? path="";
  // File? imageFile;
  @override
  Widget build(BuildContext context) {
    data=ModalRoute.of(context)!.settings.arguments as DataModel;
    return SafeArea(
        child:Scaffold(
          appBar: AppBar (
            title: Text("Detail"),
          ),
          body: ListView.builder(
            itemCount: Contact.c1.conatctList.length,
            itemBuilder: (context, index) {
              DataModel get = Contact.c1.conatctList[index];
              return Container(
                margin: const EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 0.45,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.primaries[index].shade200,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Align(
                      //   alignment: Alignment.center,
                      //   child: CircleAvatar(
                      //     backgroundImage: FileImage(File("${get.image}")),
                      //     radius: 50,
                      //   ),
                      // ),
                      Text(
                        "Name: ${get.name}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Email : ${get.email}",
                        style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Mobile Number: ${get.mobile}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                Contact.c1.conatctList.removeAt(index);
                              });
                            },
                            icon: Icon(Icons.delete,color:Colors.black),
                          ),
                          IconButton(
                            onPressed: () {
                              DataModel t1 = Contact.c1.conatctList[index];
                              txtname.text = t1.name!;
                              txtemail.text = t1.email!;
                              txtmoblie.text = t1.mobile!;
                            },
                            icon: Icon(Icons.edit,color: Colors.black),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        )
    );
  }
}
