import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sparkle_wrench/business/constants/constant.dart';
import 'package:sparkle_wrench/business/database_helper.dart';
import 'package:sparkle_wrench/presentation/components/custom_time_picker.dart';

import '../components/custom_button.dart';

class BookGeneralCarService extends StatefulWidget {
  final String carId;
  final String carName;
  final String carModel;
  final String carPicUrl;
  final String carNumber;
  final String serviceType;
  final String carColor;

  const BookGeneralCarService({
    Key? key,
    required this.carId,
    required this.carName,
    required this.serviceType,
    required this.carModel,
    required this.carNumber,
    required this.carColor, required this.carPicUrl,
  }) : super(key: key);

  @override
  State<BookGeneralCarService> createState() => _BookGeneralCarServiceState();
}

class _BookGeneralCarServiceState extends State<BookGeneralCarService> {
  TimeOfDay? timeAppointment;

  DateTime selectedDate = DateTime.now();
  DateTime mainDate = DateTime.now();
  bool isSelect = false;
  String? address;
  bool _isLoading = false;

  DateTime checkTime() {
    if (DateTime.now().isAfter(
        DateTime(mainDate.year, mainDate.month, mainDate.day, 18, 00))) {
      return DateTime(mainDate.year, mainDate.month, mainDate.day + 1);
    } else {
      return mainDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    DatabaseHelper _databaseHelper = DatabaseHelper(context);
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              'Book Services',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      String? addressText;
                      showDialog(
                        context: context,
                        builder: (context) => SimpleDialog(
                          contentPadding: EdgeInsets.all(16),
                          children: [
                            Text(
                              'Enter Address',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            TextFormField(
                              onChanged: (value) => addressText = value,
                              initialValue: address,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Cancel',
                                    style:
                                        TextStyle(color: MyConstant.mainColor),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          side: BorderSide(
                                              color: MyConstant.mainColor,
                                              width: 2))),
                                ),
                                OutlinedButton(
                                  onPressed: () async {
                                    setState(() {
                                      address = addressText;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Enter',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                      padding: EdgeInsets.all(8),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      backgroundColor: MyConstant.mainColor),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.add_location_alt,
                            color: MyConstant.mainColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Add Pick-up Address',
                                  style: TextStyle(
                                    color: MyConstant.mainColor,
                                  ),
                                ),
                                address == null ? Container() : Text(address!),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select Date',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        CalendarDatePicker(
                          firstDate: checkTime(),
                          initialDate: checkTime(),
                          lastDate: DateTime(DateTime.now().year,
                              DateTime.now().month, DateTime.now().day + 30),
                          onDateChanged: (DateTime value) {
                            setState(() {
                              selectedDate = value;
                            });
                          },
                        ),
                        const Text(
                          'Select Time',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          child: CustomTimePicker(
                            selectedDate: checkTime(),
                            callback: (value) => timeAppointment = value,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                      buttonText: 'Book Service',
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        bool check =
                            await _databaseHelper.BookAGeneralCarService(
                          bookDate: DateTime(
                              selectedDate.year,
                              selectedDate.month,
                              selectedDate.day,
                              timeAppointment!.hour,
                              timeAppointment!.minute,
                          ),
                          pickUpAddress: address,
                          carName: widget.carName,
                          carModel: widget.carModel,
                          carNumber: widget.carNumber,
                          carColor: widget.carColor,
                          carUid: widget.carId, serviceType: widget.serviceType, carPicUrl: widget.carPicUrl,
                        );
                        setState(() {
                          _isLoading = check;
                        });
                      },
                    ),
                  )
                ],
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
