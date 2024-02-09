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
          title: const Text("Home"),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: Contact.c1.conatctList.length,
          itemBuilder: (context, index) {
            DataModel get = Contact.c1.conatctList[index];
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'detail');
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 0.40,
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
                      Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          backgroundImage: FileImage(File("${get.image}")),
                          radius: 50,
                        ),
                      ),
                      Text(
                        "Name: ${get.name}",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        "Email : ${get.email}",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        "Mobile Number: ${get.mobile}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                              addDialog(context, index);
                            },
                            icon: Icon(Icons.edit, color: Colors.black),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
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
                      radius: 90,
                      backgroundImage:
                          imageFile != null ? FileImage(imageFile!) : null,
                    ),
                    Align(
                      alignment: Alignment(0.5, 0.12),
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
