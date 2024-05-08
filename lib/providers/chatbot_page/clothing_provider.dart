import 'package:flutter/material.dart';

// Provider for Gender and Style state management

class ClothingProvider extends ChangeNotifier {
  String _selectedGender = 'Male';
  String _selectedStyle = 'Casual';

  String get selectedGender => _selectedGender;
  String get selectedStyle => _selectedStyle;

  // Method to update selected gender
  void updateSelectedGender(String gender) {
    _selectedGender = gender;
    notifyListeners();
  }

  // Method to update selected style
  void updateSelectedStyle(String style) {
    _selectedStyle = style;
    notifyListeners();
  }
}