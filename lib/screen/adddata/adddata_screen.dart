import 'dart:io';
import 'package:contact_app/model/model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../utils/global.dart';

class AdddataScreen extends StatefulWidget {
  const AdddataScreen({super.key});

  @override
  State<AdddataScreen> createState() => _AdddataScreenState();
}

class _AdddataScreenState extends State<AdddataScreen> {
  TextEditingController txtname = TextEditingController();
  TextEditingController txtmoblie = TextEditingController();
  TextEditingController txtemail = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  String? path = "";
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Form(
          key: key,
          child: Scaffold(
                appBar: AppBar(
          centerTitle: true,
          title: const Text("Contact Info"),
                ),
                body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text("Information",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 10,
                ),
                Stack(
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            imageFile != null ? FileImage(imageFile!) : null,
                      ),
                    ),
                    Align(
                      alignment: Alignment(0.3,0.3),
                      child: IconButton(
                        onPressed: () async {
                          ImagePicker picker = ImagePicker();
                          XFile? image =
                              await picker.pickImage(source: ImageSource.camera);
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
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Valid Name";
                    }
                    return null;
                  },
                  controller: txtname,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter the name...",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Valid email";
                    }
                     else if(!RegExp("^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$").hasMatch(value))
                     {
                       return "enter the valid email";
                     }
                    return null;
                  },
                  controller: txtemail,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter the email...",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Valid Contact";
                    }
                    else if (value!.length!=10)
                    {
                      return "Enter the valid number";
                    }
                    return null;
                  },
                  controller: txtmoblie,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter the contact Number...",
                  ),
                ),
              ],
            ),
          ),
                ),
                floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (key.currentState!.validate()) {
              DataModel data = DataModel(
                name: txtname.text,
                email: txtemail.text,
                mobile: txtmoblie.text,
                image: path,
              );
              Contact.c1.conatctList.add(data);
              Navigator.pop(context);
            }
          },child: Icon(Icons.save),
                ),
              ),
        ),
    );
  }
}
