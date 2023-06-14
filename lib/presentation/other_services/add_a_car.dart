import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sparkle_wrench/business/constants/constant.dart';
import 'package:sparkle_wrench/presentation/components/custom_button.dart';
import 'package:sparkle_wrench/presentation/components/my_dropdownbutton.dart';
import 'package:sparkle_wrench/presentation/components/text_form_field.dart';

import '../../business/database_helper.dart';

class AddACar extends StatefulWidget {
  @override
  State<AddACar> createState() => _AddACarState();
}

class _AddACarState extends State<AddACar> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  File? imagePath;
  String? carName;
  String? carModel;
  String? carNumber;
  String? carColor;
  bool _isLoading = false;
  List carColors = [
    '--select--',
    'black',
    'red',
    'blue',
    'white',
    'yellow',
  ];

  @override
  Widget build(BuildContext context) {
    DatabaseHelper _dbHelper = DatabaseHelper(context);
    return Stack(
      children: [
        Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                        child: imagePath == null
                            ? Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border:
                                      Border.all(color: MyConstant.mainColor),
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: MyConstant.mainColor,
                                ),
                              )
                            : Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    image: DecorationImage(
                                        image: FileImage(
                                          imagePath!,
                                        ),
                                        fit: BoxFit.cover)),
                              ),
                        onTap: () async {
                          final pickedFile = await _picker.pickImage(
                              source: ImageSource.gallery);
                          if (pickedFile != null) {
                            setState(() {
                              imagePath = File(pickedFile.path);
                            });
                          }
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      MyTextField(
                        labelText: 'Car Name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Car name';
                          }
                          return null;
                        },
                        onchanged: (value) => carName = value,
                        inputType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      MyTextField(
                        labelText: 'Car Model',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Car model';
                          }
                          return null;
                        },
                        onchanged: (value) => carModel = value,
                        inputType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      MyTextField(
                        labelText: 'Car Number',
                        onchanged: (value) => carNumber = value,
                        inputType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Car Numer';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      MyDropdownButton(
                        itemList: carColors,
                        callback: (value) => carColor = carColors[value],
                        labelText: Text('Car Color'),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomButton(
                          buttonText: 'Add Car',
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if(imagePath != null){
                                setState(() {
                                  _isLoading = true;
                                });
                                bool check = await _dbHelper.AddACar(
                                  picPath: imagePath!,
                                  carName: carName!,
                                  carModel: carModel!,
                                  carColor: carColor!,
                                  carNumber: carNumber!,
                                ).whenComplete(() {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                });
                                setState(() {
                                  _isLoading = check;

                                });
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Insert a Car'),
                                  ),
                                );
                              }
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        if (_isLoading)
          const Opacity(
            opacity: 0.8,
            child: ModalBarrier(
              dismissible: false,
              color: Colors.black12,
            ),
          ),
        if (_isLoading)
          const Center(
            child: CircularProgressIndicator(),
          )
      ],
    );
  }
}
