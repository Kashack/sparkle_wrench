import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sparkle_wrench/business/constants/constant.dart';
import 'package:sparkle_wrench/presentation/components/custom_button.dart';
import 'package:sparkle_wrench/presentation/services/select_car.dart';

class CarWashingServices extends StatefulWidget {
  @override
  State<CarWashingServices> createState() => _CarWashingServicesState();
}

class _CarWashingServicesState extends State<CarWashingServices> {
  int? tag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Car Wash Services',
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
            Text('Select Your Service',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
            Expanded(
              child: Column(
                children: List.generate(
                  washServices.length,
                  (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ChoiceChip(
                      elevation: tag == index ? 2 : 0,
                      selected: tag == index,
                      backgroundColor: Colors.white,
                      labelPadding: EdgeInsets.symmetric(horizontal: 8),
                      iconTheme: IconThemeData(
                        color: tag != null ? Colors.lightBlue : Colors.white,
                      ),
                      pressElevation: 5,
                      labelStyle: tag == index
                          ? const TextStyle(color: Colors.white)
                          : const TextStyle(color: Colors.black),
                      selectedColor: MyConstant.mainColor,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20  , horizontal: 20),
                      shape: RoundedRectangleBorder(
                          side: tag == index
                              ? BorderSide.none
                              : const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20)),
                      label: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${washServices[index]['Name']}'),
                        ],
                      ),
                      onSelected: (bool selected) {
                        setState(() {
                          // gender = selected ? genderList[index] : null;
                          tag = (selected ? index : null)!;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                buttonText: 'Book Services',
                onPressed: () {
                  if(tag != null){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectCar(
                            serviceType: washServices[tag!]['Name'],
                          ),
                        ));
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

List<Map<String, dynamic>> washServices = [
  {
    'Name' : 'Full Car Wash',
    'Icon' : Icon(CupertinoIcons.car_detailed)
  },
  {
    'Name' : 'Outer Body Wash',
    'Icon' : Icon(Icons.car_repair)
  },
  {
    'Name' : 'Interior Cleaning',
    'Icon' : Icon(Icons.car_rental)
  },
  {
    'Name' : 'Enginge Detailing',
    'Icon' : Icon(CupertinoIcons.car_detailed)
  },
];
