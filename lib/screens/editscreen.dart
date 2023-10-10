// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lastapp/functions/dbfunctions.dart';
import 'package:lastapp/model/dbmodel.dart';
import 'package:lastapp/screens/liststudent.dart';


class EditScreen extends StatefulWidget {
  final String name;
  final String age;
  final String course;
  final String phoneNumber;
  final String image;
  final int index;

  const EditScreen({super.key, 
    required this.name,
    required this.age,
    required this.course,
    required this.phoneNumber,
    required this.image,
    required this.index,
  });

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  File? selectimage;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
    _ageController.text = widget.age;
    _courseController.text = widget.course;
    _phoneNumberController.text = widget.phoneNumber;
    selectimage=widget.image!= null ? File(widget.image):null;
  }

  Future<void> updateStudent(int index) async {
    final studentDb = await Hive.openBox<studentModel>("student_db");

    if (index >= 0 && index < studentDb.length) {
      final updatedStudent = studentModel(
        name: _nameController.text,
        age: _ageController.text,
        coures: _courseController.text,
        numb: _phoneNumberController.text,
        image: selectimage!.path,
      );

      await studentDb.putAt(index, updatedStudent);
      getAllStud();

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const ListStudent(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Student'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(40),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(backgroundColor: Colors.black,child: IconButton(onPressed: (){
                    fromcam();
                  }, icon: Icon(Icons.add_a_photo),),radius: 60,),
                  SizedBox(height: 10,),
                  ElevatedButton.icon(onPressed: (){
                     fromgallery();
                  }, 
                  icon:Icon(Icons.camera_alt_outlined), label:Text("Gallery")),
                  SizedBox(height: 20,),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    inputFormatters:[FilteringTextInputFormatter.allow(RegExp(r'[a-zA-z\s]'))],
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      labelText: "Name",
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: _ageController,
                    decoration:  InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      labelText: "Age",
                      prefixIcon: Icon(Icons.calendar_month),
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    inputFormatters:[FilteringTextInputFormatter.allow(RegExp(r'[a-zA-z\s]'))],
                    controller: _courseController,
                    decoration:  InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      labelText: "Course",
                      prefixIcon: Icon(Icons.book),
                    ),
                  ),
                  SizedBox(height: 10,),
                   TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: _phoneNumberController,
                    decoration:  InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      labelText: "phone",
                      prefixText: "+91",
                      prefixIcon: Icon(Icons.phone),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await updateStudent(widget.index);
                    },
                    child: const Text("Update"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
    fromgallery() async {
    final returnedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      selectimage = File(returnedimage!.path);
    });
  }

  fromcam() async {
    final returnedimage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      selectimage = File(returnedimage!.path);
    });
  }
}
