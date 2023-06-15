import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sparkle_wrench/business/constants/constant.dart';

class TrackOrder extends StatelessWidget {
  String bookingId;
  TrackOrder({required this.bookingId});
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> upcomingStream = _firestore
        .collection('appointments').doc(bookingId)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Track Order',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream: upcomingStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.connectionState == ConnectionState.none) {
                return Center(child: Text('Check Your Network'),);
              }
              if (snapshot.hasData) {
                Map getSnap = snapshot.data!.data() as Map<String, dynamic>;
                return  Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          '${snapshot.data!.get('serviceType')}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text('Booking ID: ${snapshot.data!.id}',style: TextStyle(fontSize: 16),)
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                ],
                              ),
                            ),
                            const Divider(),
                            Expanded(
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        getSnap['carName'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: MyConstant.mainColor,
                              shape: BoxShape.circle
                            ),
                            padding: EdgeInsets.all(8),
                            height: 30,
                            width: 30,
                          ),
                          SizedBox(width: 10,),
                          Text('New Parts Arrived',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  // color: MyConstant.mainColor,
                                  shape: BoxShape.circle,
                                border: Border.all(color: MyConstant.mainColor)
                              ),
                              height: 30,
                              width: 30,
                              padding: EdgeInsets.all(8),
                            ),
                            SizedBox(width: 10,),
                            Text('Installation',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                // color: MyConstant.mainColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: MyConstant.mainColor)
                              ),
                              height: 30,
                              width: 30,
                              padding: EdgeInsets.all(8),
                            ),
                            SizedBox(width: 10,),
                            Text('Final Inspection',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                // color: MyConstant.mainColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: MyConstant.mainColor)
                              ),
                              height: 30,
                              width: 30,
                              padding: EdgeInsets.all(8),
                            ),
                            SizedBox(width: 10,),
                            Text('Ready for Drop',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                // color: MyConstant.mainColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: MyConstant.mainColor)
                              ),
                              height: 30,
                              width: 30,
                              padding: EdgeInsets.all(8),
                            ),
                            SizedBox(width: 10,),
                            Text('Dropped',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Center(child: Text('Check Your Network'),);
            },
          ),
        ],
      ),
    );
  }
}
