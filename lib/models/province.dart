import 'dart:io';

/*
  * TYPE: Model Class
  * NAME: Diagnosis
  * USAGE: It is used to hold and represent a diagnosis data
  * */
class Province {
  int _id;
  String _province_name;

  Province.name(this._id, this._province_name);

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get province_name => _province_name;

  set province_name(String value) {
    _province_name = value;
  }
}