import 'package:flutter/material.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: _size.height,
        width: _size.width,
        child: Column(
          children: [
            Spacer(
              flex: 2,
            ),
            // Image.asset(),
            Text('Sorry you hava no intenet connection'),
            Spacer(
              flex: 2,
            )
          ],
        ),
      ),
    );
  }
}
