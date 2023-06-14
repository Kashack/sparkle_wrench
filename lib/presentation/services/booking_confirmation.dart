import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sparkle_wrench/business/constants/constant.dart';
import 'package:sparkle_wrench/presentation/navigation/nav_page.dart';

class BookConfirmation extends StatelessWidget {
  const BookConfirmation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // order_confirmed
              SvgPicture.asset(
                'assets/icons/order_confirmed.svg',
                width: 200,
                height: 200,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Order was placed Successfully!',
                style: TextStyle(color: MyConstant.mainColor,fontWeight: FontWeight.bold,fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'We’ve received your order and our team is working to get it to you as quick as possible.',
                style: TextStyle(),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                color: MyConstant.mainColor,
                onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomNavigationPages(),
                    ),
                        (route) => false);
              },child: Text('Go To Home',style: TextStyle(color: Colors.white),),)
            ],
          ),
        ),
      ),
    );
  }
}
