import 'package:flutter/material.dart';
import 'package:sparkle_wrench/business/constants/constant.dart';
import 'package:sparkle_wrench/presentation/record_appointment/past.dart';
import 'package:sparkle_wrench/presentation/record_appointment/upcoming.dart';

class RecordPage extends StatelessWidget {
  const RecordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text('My Appointment',style: TextStyle(color: Colors.black)),
          bottom: const TabBar(
            indicatorColor: MyConstant.mainColor,
            labelColor: Colors.black,
            tabs: [
              Tab(
                text: 'UPCOMING',
              ),
              Tab(
                text: 'PAST',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            UpcomingAppointment(),
            PastAppointment(),
          ],
        ),
      ),
    );
  }
}
