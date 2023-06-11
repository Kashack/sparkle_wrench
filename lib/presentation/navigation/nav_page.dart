import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sparkle_wrench/business/constants/constant.dart';
import 'package:sparkle_wrench/presentation/navigation/records_page.dart';
import 'package:sparkle_wrench/presentation/navigation/vehicles_page.dart';

import 'home_page.dart';

class BottomNavigationPages extends StatefulWidget {
  @override
  State<BottomNavigationPages> createState() => _BottomNavigationPagesState();
}

class _BottomNavigationPagesState extends State<BottomNavigationPages> {
  int _selectindex = 0;

  List navPage = [HomePage(), VehiclePage(), RecordPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello Kamal',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text('Lagos, Nigeria')
                    ],
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                          image: AssetImage('assets/images/profile.jpeg'),
                          fit: BoxFit.fill),
                    ),
                  )
                ],
              ),
              Expanded(child:navPage[_selectindex]
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectindex,
        onTap: (value) => setState(() {
          _selectindex = value;
        }),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset('assets/icons/home.svg'),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/vehicle.svg',
              colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/vehicle.svg',
              colorFilter:
                  ColorFilter.mode(MyConstant.mainColor, BlendMode.srcIn),
            ),
            label: 'Vehicle',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/record.svg',
              colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/record.svg',
              colorFilter:
                  ColorFilter.mode(MyConstant.mainColor, BlendMode.srcIn),
            ),
            label: 'Record',
          ),
        ],
      ),
    );
  }
}
