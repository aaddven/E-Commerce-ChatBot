import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// TextField Widget for Username and Password

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final bool obscureText;
  final Function(String) onSubmitted;

  const CustomTextField({
    Key? key,
    required this.controller,
    this.hintText = "Username",
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    required this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    const isWeb = identical(0, 0.0);

    return Container(
      height: MediaQuery.of(context).size.height*0.06,
      width: isWeb? MediaQuery.of(context).size.width*0.3 : MediaQuery.of(context).size.width*0.6,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF7165E3).withOpacity(0.6),
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: Colors.transparent),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
              child: TextFormField(
                controller: controller,
                keyboardType: keyboardType,
                obscureText: obscureText,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                ),
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                cursorColor: Colors.white.withOpacity(0.8),
                textAlignVertical: TextAlignVertical.center,
                onFieldSubmitted: onSubmitted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}