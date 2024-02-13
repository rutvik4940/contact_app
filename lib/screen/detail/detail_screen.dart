import 'dart:io';

import 'package:contact_app/model/model.dart';
import 'package:contact_app/utils/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  DataModel? get;
  TextEditingController txtname = TextEditingController();
  TextEditingController txtmoblie = TextEditingController();
  TextEditingController txtemail = TextEditingController();
  String? path = "";
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    get = ModalRoute
        .of(context)!
        .settings
        .arguments as DataModel;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Detail"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: CircleAvatar(
                  backgroundImage: FileImage(File("${get?.image}")),
                  radius: 60,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Icon(Icons.phone_rounded),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Name"),
                      Text(
                        "${get?.name}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Icon(Icons.email),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Email"),
                      Text(
                        "${get?.email}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Icon(Icons.person),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Number"),
                      Text(
                        "${get?.mobile}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}