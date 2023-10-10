// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lastapp/functions/dbfunctions.dart';
import 'package:lastapp/model/dbmodel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lastapp/screens/liststudent.dart';



class addstuds extends StatefulWidget {
  addstuds({super.key});

  @override
  State<addstuds> createState() => _addstudsState();
}

class _addstudsState extends State<addstuds> {
  final _namecontroller = TextEditingController();

  final _corsecontroller = TextEditingController();

  final _agecontroller = TextEditingController();

  final _numbercontroller = TextEditingController();
  final ImagePicker imagePicker = ImagePicker();
  File? picked;

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => getimage(ImageSource.camera),
                      child: CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 82, 199, 88),
                        radius: 60,
                        child: picked == null
                            ? Icon(Icons.camera_alt)
                            : ClipOval(
                                child: Image.file(
                                  picked!,
                                  fit: BoxFit.cover,
                                  height: 120,
                                  width: 120,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.camera_alt_outlined),
                        label: Text("Camera")),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-z\s]'))
                      ],
                      controller: _namecontroller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: "Name",
                        hintText: "Enter your Name",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'value is empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        keyboardType: TextInputType.name,
                        controller: _corsecontroller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "courses",
                          hintText: "Enter your course",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'value is empty';
                          } else {
                            return null;
                          }
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: _agecontroller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "Age",
                          hintText: "Enter your Age",
                        ),
                        maxLength: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'value is empty';
                          } else {
                            return null;
                          }
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: _numbercontroller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "phone",
                          hintText: "enter your phone number",
                          prefixText: "+91",
                        ),
                        maxLength: 10,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'value is empty';
                          } else {
                            return null;
                          }
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            onAddStudentOnClick();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ListStudent()));
                          }
                        },
                        child: Text("Add"))
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onAddStudentOnClick() async {
    final _name = _namecontroller.text.trim();
    final _age = _agecontroller.text.trim();
    final _class = _corsecontroller.text.trim();
    final _numb = _numbercontroller.text.trim();
    if (_name.isEmpty || _age.isEmpty || _class.isEmpty) {
      return;
    }

    final _student = studentModel(
        name: _name,
        coures: _class,
        age: _age,
        numb: _numb,
        image: picked?.path ?? '');

    addstud(_student);
  }

  getimage(ImageSource source) async {
    var img = await imagePicker.pickImage(source: source);
    setState(() {
      picked = File(img!.path);
    });
  }
}
