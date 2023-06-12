import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sparkle_wrench/presentation/navigation/records_page.dart';
import 'package:sparkle_wrench/presentation/user_profile.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Service',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecordPage(),
                          ));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
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
                            height: 30,
                            width: 30,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(services[index]['text'])
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> services = [
  {'text': 'Veterian', 'image': 'assets/icons/car_services.svg', 'navigation': UserProfile()},
  {
    'text': 'Grooming',
    'image': 'assets/icons/wheel.svg',
    'navigation':  UserProfile()
  },
  {
    'text': 'Pet boarding',
    'image': 'assets/icons/painting.svg',
    'navigation':  UserProfile()
  },
  {
    'text': 'Adoption',
    'image': 'assets/icons/ac_repair.svg',
    'navigation':  UserProfile()
  },
  {
    'text': 'Dog walking',
    'image': 'assets/icons/car_wash.svg',
    'navigation':  UserProfile()
  },
  {
    'text': 'Training',
    'image': 'assets/icons/insurance_claims.svg',
    'navigation': UserProfile()
  },

];