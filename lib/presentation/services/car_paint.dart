import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:sparkle_wrench/presentation/components/custom_button.dart';
import 'package:sparkle_wrench/presentation/services/select_car.dart';

class CarPaintingServices extends StatefulWidget {
  @override
  State<CarPaintingServices> createState() => _CarPaintingServicesState();
}

class _CarPaintingServicesState extends State<CarPaintingServices> {
  Color color = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Car Paint Services',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Select your Color',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  Container(
                    margin: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                    ),
                    width: 120,
                    height: 120,
                  ),

                  FilledButton(
                    onPressed: () => pickColor(context),
                    child: Text('Click me to change Color'),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                buttonText: 'Book Services',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectCar(
                          serviceType: 'Car Panting',
                        ),
                      ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  pickColor(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pick Your Color'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ColorPicker(
              pickerColor: color,
              onColorChanged: (color) {
                setState(() {
                  this.color = color;
                });
              },
            ),
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Select',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
