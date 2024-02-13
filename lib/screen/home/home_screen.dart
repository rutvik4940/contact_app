

import 'dart:io';

import 'package:contact_app/model/model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/global.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController txtname = TextEditingController();
  TextEditingController txtmoblie = TextEditingController();
  TextEditingController txtemail = TextEditingController();
  String? path = "";
  File? imageFile;
  bool isGrid = true;
  List colorList = [Colors.primaries];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Mediator",style: TextStyle(fontWeight: FontWeight.bold)),
          leading: const Icon(Icons.menu),
          actions: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.search_rounded),
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: Contact.c1.conatctList.length,
          itemBuilder: (context, index) {
            DataModel get = Contact.c1.conatctList[index];
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, 'detail',arguments: get);
                  },


                  child: Container(
                    margin: const EdgeInsets.all(10),
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundImage: FileImage(File("${get.image}")),
                              radius: 30,
                            ),
                           const SizedBox(width: 20,),
                           Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                 "${get.name}",
                                 style: const TextStyle(
                                   fontSize: 20,
                                   fontWeight: FontWeight.bold,
                                 ),
                               ),
                               Text(
                                 "${get.mobile}",
                                 style: const TextStyle(
                                   fontSize: 20,
                                 ),
                               ),
                             ],
                           ),
                            Spacer(),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  Contact.c1.conatctList.removeAt(index);
                                });
                              },
                              icon: Icon(Icons.delete, color: Colors.black),
                            ),
                            IconButton(
                              onPressed: () {
                                DataModel t1 = Contact.c1.conatctList[index];
                                txtname.text = t1.name!;
                                txtemail.text = t1.email!;
                                txtmoblie.text = t1.mobile!;
                                addDialog(context,index);
                              },
                              icon: Icon(Icons.edit, color: Colors.black),
                            )

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: const Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.home),
              Icon(Icons.phone_in_talk),
              Icon(Icons.notifications),
              Icon(Icons.people_rounded),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "add").then(
                  (value) {
                setState(() {});
              },
            );
          },
          child: const Icon(Icons.add),
        ),

      ),
    );
  }
  addDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: AlertDialog(
            actions: [
              Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                      imageFile != null ? FileImage(imageFile!) : null,
                    ),
                    Align(
                      alignment: Alignment(0.5, 0.5),
                      child: IconButton(
                        onPressed: () async {
                          ImagePicker picker = ImagePicker();
                          XFile? image = await picker.pickImage(
                              source: ImageSource.camera);
                          if (image != null) {
                            setState(() {
                              path = image.path;
                              imageFile = File(path!);
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.add_a_photo_rounded,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: txtname,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Name"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: txtemail,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Email"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: txtmoblie,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: "Mobile Number"),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(
                        () {
                      Contact.c1.conatctList[index] = DataModel(
                        name: txtname.text,
                        email: txtemail.text,
                        mobile: txtmoblie.text,
                        image: path,
                      );
                    },
                  );
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );
      },
    );
  }
}

