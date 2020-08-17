import 'dart:io';

/*
  * TYPE: Model Class
  * NAME: Diagnosis
  * USAGE: It is used to hold and represent a diagnosis data
  * */
class Diagnosis {
  File _image;
  String _confidence;
  String _result;

  File get image => _image;

  set image(File value) {
    _image = value;
  }

  String get confidence => _confidence;
  String get result     => _result;

  set result(String value) {
    _result = value;
  }

  set confidence(String value) {
    _confidence = value;
  }
}