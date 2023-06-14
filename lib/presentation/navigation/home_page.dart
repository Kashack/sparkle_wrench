import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sparkle_wrench/presentation/navigation/records_page.dart';
import 'package:sparkle_wrench/presentation/services/booking_confirmation.dart';
import 'package:sparkle_wrench/presentation/services/car_paint.dart';
import 'package:sparkle_wrench/presentation/services/general_car_services.dart';
import 'package:sparkle_wrench/presentation/services/select_car.dart';
import 'package:sparkle_wrench/presentation/services/washing_services.dart';
import 'package:sparkle_wrench/presentation/settings_screens/user_profile.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 16,
            ),
            Stack(
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      // color: Colors.lightGreen,
                      borderRadius: BorderRadius.circular(20)),
                  child: Image.asset(
                    'assets/images/car_wash.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                    bottom: 0,
                    left: 16,
                    child: MaterialButton(
                      color: Colors.red,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CarWashingServices(),
                            ));
                      },
                      child: Text('Book Now',
                          style: TextStyle(color: Colors.white)),
                    ))
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Select Service',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Expanded(
                child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 8.0,
              children: List.generate(
                  services.length,
                  (index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    services[index]['navigation'],
                              ));
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 4,
                                    spreadRadius: 0,
                                    color: Color(0x40000000),
                                    offset: Offset(0, 4))
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                services[index]['image'],
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                services[index]['text'],
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      )),
            ))
          ],
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> services = [
  {
    'text': 'General Car Services',
    'image': 'assets/icons/car_services.svg',
    'navigation': GeneralCarServices()
  },
  {
    'text': 'Car Wash',
    'image': 'assets/icons/car_wash.svg',
    'navigation': CarWashingServices()
  },
  {
    'text': 'Denting & Painting',
    'image': 'assets/icons/painting.svg',
    'navigation': CarPaintingServices()
  },
  {
    'text': 'Tyres & Wheel Care',
    'image': 'assets/icons/wheel.svg',
    'navigation': SelectCar(
      serviceType: 'Tyres & Wheel Care',
    )
  },
  {
    'text': 'AC Repair',
    'image': 'assets/icons/ac_repair.svg',
    'navigation': SelectCar(
      serviceType: 'AC Repair',
    )
  },
  {
    'text': 'Clutch & Brakes',
    'image': 'assets/icons/clutches.svg',
    'navigation': SelectCar(
      serviceType: 'Clutch & Brakes',
    )
  },
];
