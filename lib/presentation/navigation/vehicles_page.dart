import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sparkle_wrench/business/constants/constant.dart';
import 'package:sparkle_wrench/presentation/other_services/add_a_car.dart';

class VehiclePage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                            return Container(
                              padding: EdgeInsets.all(8),
                              margin: EdgeInsets.symmetric(vertical: 8),
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              data['carPicUrl']
                                             ),
                                          fit: BoxFit.fill
                                        ),
                                        borderRadius: BorderRadius.circular(15)
                                      ),
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                  Expanded(
                                    child: SizedBox(
                                    ),
                                  ),
                                  IconButton(onPressed: () {
                                    try {
                                      _firestore
                                          .collection('users')
                                          .doc(_auth.currentUser!.uid)
                                          .collection('Car').doc(document.id)
                                          .delete();
                                    } on FirebaseException catch (e) {
                                      if (e.code ==
                                          "network-request-failed") {
                                        ScaffoldMessenger.of(
                                            context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Network failed'),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(
                                            context)
                                            .showSnackBar(SnackBar(
                                            content: Text(
                                                '${e.code}')));
                                      }
                                    }
                                  },icon: Icon(Icons.delete_forever_rounded,color: Colors.red,))
                                ],
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
