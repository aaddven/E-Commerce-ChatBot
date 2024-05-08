import 'package:flutter/material.dart';

// Login Button Widget

class LoginButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final double borderRadius;
  final double width;
  final double height;

     LoginButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.backgroundColor = const Color(0xFF7165E3),
    this.borderRadius = 5.0,
    this.width = 368.0,
    this.height = 50.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        minimumSize: Size(MediaQuery.of(context).size.width*0.175,MediaQuery.of(context).size.height*0.06 ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 28,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}