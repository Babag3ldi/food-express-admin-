import 'package:flutter/material.dart';

class ProviderPage extends ChangeNotifier {
  String _uid = '';
  String get uid => _uid;

  void uidSetter(String uId, ) {
    _uid = uId;
  }
}