import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sparkle_wrench/presentation/services/book_general_car_services.dart';

import '../../business/constants/constant.dart';
import '../components/custom_button.dart';
import '../other_services/add_a_car.dart';

class SelectCar extends StatefulWidget {
  final String serviceType;

  SelectCar({required this.serviceType});

  @override
  State<SelectCar> createState() => _SelectCarState();
}

class _SelectCarState extends State<SelectCar> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? kcarName;

  String? kcarModel;
  String? kcarPicUrl;

  String? kcarNumber;

  String? kcarColor;

  String? tag;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> userStream = _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('Car')
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Cars',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Select A Car',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
                      StreamBuilder<QuerySnapshot>(
                          stream: userStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Container();
                            }
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Container();
                            }
                            if (snapshot.connectionState == ConnectionState.none) {
                              return Container();
                            }
                            if (snapshot.hasData) {
                              // String carName = snapshot.data.docs['']''
                              return Column(
                                children: snapshot.data!.docs
                                    .map((DocumentSnapshot document) {
                                  Map<String, dynamic> data =
                                      document.data()! as Map<String, dynamic>;
                                  String carName = data['car_name'];
                                  String carColor = data['car_color'];
                                  String carModel = data['car_model'];
                                  String carNumber = data['car_number'];
                                  String carPicUrl = data['carPicUrl'];
                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8.0),
                                    child: ChoiceChip(
                                      selected: tag == document.id,
                                      onSelected: (bool selected) {
                                        setState(() {
                                          kcarName = carName;
                                          kcarNumber = carNumber;
                                          kcarModel = carModel;
                                          kcarColor = carColor;
                                          tag = (selected ? document.id : null)!;
                                        });
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20)),
                                      backgroundColor: Colors.white,
                                      label: Container(
                                        padding: EdgeInsets.all(8),
                                        height: 100,
                                        // decoration: BoxDecoration(
                                        //   color: Colors.white,
                                        // ),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(right: 8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    image: DecorationImage(
                                                        image:
                                                            CachedNetworkImageProvider(
                                                                data['carPicUrl']),
                                                        fit: BoxFit.fill),
                                                    borderRadius:
                                                        BorderRadius.circular(15)),
                                                width: 100,
                                                height: 100,
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    carName,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  Text(
                                                    carModel,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Reg ID : $carNumber',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                            }
                            return Container();
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddACar(),
                              ));
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          height: 50,
                          alignment: Alignment.center,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.grey,
                              )),
                          child: Text('ADD CAR',
                              style: TextStyle(
                                color: MyConstant.mainColor,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                buttonText: 'Proceed',
                onPressed: () {
                  if (tag != null){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookGeneralCarService(
                            carName: kcarName!,
                            carModel: kcarModel!,
                            carNumber: kcarNumber!,
                            carId: tag!, carColor: kcarColor!, serviceType: widget.serviceType, carPicUrl: kcarPicUrl!,
                          ),
                        ));
                  }else{

                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
