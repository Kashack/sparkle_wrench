import 'package:flutter/material.dart';
import 'package:sparkle_wrench/business/constants/constant.dart';
import 'package:sparkle_wrench/presentation/components/custom_button.dart';
import 'package:sparkle_wrench/presentation/services/book_general_car_services.dart';
import 'package:sparkle_wrench/presentation/services/select_car.dart';

class GeneralCarServices extends StatelessWidget {
  const GeneralCarServices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'General Services',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                    padding: EdgeInsets.all(4),
                    margin: EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(50)),
                    child: Icon(
                      Icons.car_repair,
                      color: MyConstant.mainColor,
                    )),
                Text('4 Hrs Taken')
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                    padding: EdgeInsets.all(4),
                    margin: EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(50)),
                    child: Icon(
                      Icons.security_update_warning_rounded,
                      color: MyConstant.mainColor,
                    )),
                Text('1000 Kms or 1 Month Warranty')
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                    padding: EdgeInsets.all(4),
                    margin: EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(50)),
                    child: Icon(
                      Icons.thumb_up_alt_rounded,
                      color: MyConstant.mainColor,
                    )),
                Text('Every 5000 Kms or 3 Months')
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                    padding: EdgeInsets.all(4),
                    margin: EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(50)),
                    child: Icon(
                      Icons.timer,
                      color: MyConstant.mainColor,
                    )),
                Text('Free Pick-up or Drop')
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            Text(
              'What\'s included',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.lightGreen,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Engine Oil Replacement')
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.lightGreen,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Oil Filter Replacement')
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.lightGreen,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Air Filter Cleaning')
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.lightGreen,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Coolant Top up')
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.lightGreen,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Wiper Fluid Replacement')
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.lightGreen,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Car Wash')
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.lightGreen,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Heater/Spark Plugs Checking')
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                buttonText: 'Book Services',
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SelectCar(serviceType: 'General Car Service',),));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
