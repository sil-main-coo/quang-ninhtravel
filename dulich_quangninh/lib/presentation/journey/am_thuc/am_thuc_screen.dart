import 'package:flutter/material.dart';

class AmThucScreen extends StatefulWidget {
  @override
  _AmThucScreenState createState() => _AmThucScreenState();
}

class _AmThucScreenState extends State<AmThucScreen> {

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'hero3',
      child: Scaffold(
        appBar: AppBar(
          title: Text('Đặc sản ẩm thực'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
        body: Center(child: Text('Ẩm thực'),)
      ),
    );
  }
}
