import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sparkle_wrench/business/constants/constant.dart';

class TrackOrder extends StatefulWidget {
  String bookingId;
  TrackOrder({required this.bookingId});

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  int currentStep = 0;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> upcomingStream =
    _firestore.collection('appointments').doc(widget.bookingId).snapshots();
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
          Expanded(
            child: StreamBuilder(
              stream: upcomingStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.connectionState == ConnectionState.none) {
                  return Center(
                    child: Text('Check Your Network'),
                  );
                }
                if (snapshot.hasData) {
                  Map getSnap = snapshot.data!.data() as Map<String, dynamic>;
                  if (getSnap.containsKey('currentStep')) {
                    currentStep = getSnap['currentStep'];
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16),
                    child: Column(
                      children: [
                        Container(
                          height: 130,
                          margin: EdgeInsets.symmetric(vertical: 16),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 100,
                                  margin: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              getSnap['carPicUrl']),
                                          fit: BoxFit.fill)),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      '${getSnap['serviceType']}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text('Booking ID: ${snapshot.data!.id}'),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                            ],
                          ),
                        ),
                        TrackButton(
                          trackTitle: 'Car Arrived',
                          currentIndex: 1, currentStep: currentStep,
                        ),
                        TrackButton(
                          trackTitle: 'Installation',
                          currentIndex: 2,
                          currentStep: currentStep,
                        ),
                        TrackButton(
                          trackTitle: 'Final Inspection',
                          currentIndex: 3,
                          currentStep: currentStep,
                        ),
                        TrackButton(
                          trackTitle: 'Ready for Drop',
                          currentIndex: 4,
                          currentStep: currentStep,
                        ),
                        TrackButton(
                          trackTitle: 'Dropped',
                          currentIndex: 5,
                          currentStep: currentStep,
                        ),
                      ],
                    ),
                  );
                }
                return Center(
                  child: Text('Check Your Network'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TrackButton extends StatefulWidget {
  TrackButton({
    required this.trackTitle,
    required this.currentIndex,
    required this.currentStep,
  });

  final String trackTitle;
  final int currentIndex;
  final int currentStep;

  @override
  State<TrackButton> createState() => _TrackButtonState();
}

class _TrackButtonState extends State<TrackButton> {
  bool isTaped = false;
  bool isFirst = false;

  @override
  void initState() {
    super.initState();
    if(widget.currentIndex <= widget.currentStep){
      isTaped = true;
      isFirst = true;
    }
  }
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: isTaped ? MyConstant.mainColor : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: MyConstant.mainColor)),
              height: 30,
              width: 30,
              padding: EdgeInsets.all(8),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              widget.trackTitle,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
