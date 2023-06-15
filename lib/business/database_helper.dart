import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sparkle_wrench/presentation/navigation/home_page.dart';
import 'package:sparkle_wrench/presentation/other_services/add_a_car.dart';
import 'package:sparkle_wrench/presentation/services/booking_confirmation.dart';

class DatabaseHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  var context;

  DatabaseHelper(BuildContext context) {
    this.context = context;
  }

  Future updateProfilePic(File picPath) async {
    final filePath = 'profile_${_auth.currentUser!.uid}';
    try {
      await _storage.ref(filePath).putFile(picPath).then((value) {
        value.ref.getDownloadURL().then((valueUrl) {
          _firestore.collection('users').doc(_auth.currentUser!.uid).update({
            'profilePicUrl': valueUrl,
          });
        }, onError: (e) => print("Error getting document: $e"));
      });
    } on FirebaseException catch (e) {
      if (e.code == "network-request-failed") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Network failed'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${e.code}')));
      }
    }
  }

  Future<bool> updateUserProfile({
    required String fullname,
    required DateTime DateOfBirth,
    required String phoneNumber,
    required String Gender,
  }) async {
    try {
      await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
        'fullname': fullname,
        'dateOfBirth': DateOfBirth,
        'gender': Gender,
        'phoneNumber': phoneNumber
      });
    } on FirebaseException catch (e) {
      if (e.code == "network-request-failed") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Network failed'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${e.code}')));
      }
    }

    return false;
  }

  Future<bool> BookAGeneralCarService({
    required DateTime bookDate,
    String? pickUpAddress,
    required String carName,
    required String carModel,
    required String carNumber,
    required String carPicUrl,
    required String carColor,
    required String carUid,
    required String serviceType,
  }) async {
    await _firestore.collection('appointments').add({
      'bookDate': bookDate,
      'userUid': _auth.currentUser!.uid,
      'appointment_status': 'Upcoming',
      'serviceType' : serviceType,
      'carUid': carUid,
      'carPicUrl': carPicUrl,
      'carName': carName,
      'carColor': carColor,
      'carModel': carModel,
      'carNumber': carNumber,
      'pickUpAddress': pickUpAddress,
    }).then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => BookConfirmation(),
          ),
          (route) => false);
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${error}')));
    }).catchError((e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${e.code}')));
    });
    return false;
  }

  Future<bool> AddACar({
    required File picPath,
    required String carName,
    required String carModel,
    required String carColor,
    required String carNumber,
  }) async {
    final filePath = 'car/$carNumber';
    try {
      await _storage.ref(filePath).putFile(picPath).then((value) {
        value.ref.getDownloadURL().then((valueUrl) async {
          await _firestore
              .collection('users')
              .doc(_auth.currentUser!.uid)
              .collection('Car')
              .add({
            'carPicUrl': valueUrl,
            'car_name': carName,
            'car_model': carModel,
            'car_color': carColor,
            'car_number': carNumber,
          }).then((value) {
            Navigator.pop(context);
          });
        }, onError: (e) => print("Error getting document: $e"));
      });
    } on FirebaseException catch (e) {
      if (e.code == "network-request-failed") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Network failed'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${e.code}')));
      }
    }
    return false;
  }

  Future<bool> ReScheduleAnAppointment({
    required DateTime appointmentStart,
    required DateTime appointmentEnd,
    required String appointmentUid,
    required String doctorUid,
  }) async {
    await _firestore.collection('appointments').doc(appointmentUid).update({
      'appointment_start': appointmentStart,
      'appointment_end': appointmentEnd,
      'appointment_status': 'Upcoming',
    }).then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
          (route) => false);
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${error}')));
    }).catchError((e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${e.code}')));
    });
    return false;
  }
}
