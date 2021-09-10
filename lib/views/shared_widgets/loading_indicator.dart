import 'package:flutter/material.dart';
import 'package:madrasah_app/views/styles/styles.dart';

class LoadingIndicator extends StatelessWidget {
  LoadingIndicator({this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        color: Colors.black87,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _getLoadingIndicator(),
              _getHeading(context),
              text != null ? _getText(text ?? '') : const SizedBox.shrink(),
            ]));
  }

  Padding _getLoadingIndicator() {
    return const Padding(
        child: SizedBox(
            child: CircularProgressIndicator(strokeWidth: 3),
            width: 32,
            height: 32),
        padding: EdgeInsets.only(bottom: 16));
  }

  Widget _getHeading(context) {
    return const Padding(
        child: Text(
          'Please wait..',
          style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: Fonts.monserrat,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        padding: EdgeInsets.only(bottom: 4));
  }

  Text _getText(String displayedText) {
    return Text(
      displayedText,
      style: const TextStyle(
          color: Colors.white, fontSize: 14, fontFamily: Fonts.monserrat),
      textAlign: TextAlign.center,
    );
  }
}
