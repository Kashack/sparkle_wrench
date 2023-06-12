import 'package:flutter/material.dart';
import 'package:sparkle_wrench/business/constants/constant.dart';

class VehiclePage extends StatelessWidget {
  const VehiclePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(),
              Text(
                'Add another car',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Registration ID...',
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text('ADD CAR',
                            style: TextStyle(
                              color: MyConstant.mainColor,
                            )),
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: MyConstant.mainColor),
                            borderRadius: BorderRadius.circular(10)
                          )
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
