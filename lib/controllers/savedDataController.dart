import 'dart:io';
import 'package:flutter/services.dart';
import 'package:prototype/models/diagnosis.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

/*
  * TYPE: Controller Class
  * NAME: HomeController
  * USAGE: It is used to provide data of the diagnosis model to the homeview and react the user's actions in the homeview
  * */
class HomeController {
  Diagnosis diagnosis = new Diagnosis();

  /*
  * TYPE: Method
  * NAME: selectDiagnosisImage
  * USAGE: It is used to select an image either from the gallery or from the camera
  * */
  Future<File> selectDiagnosisImage(var camera) async {
    var image;
    final _picker = ImagePicker();

    if (camera)
      image = await _picker.getImage(source: ImageSource.camera);
    else
      image = await _picker.getImage(source: ImageSource.gallery);

    if (image == null) return null;

    return File(image.path);
  }

  /*
  * TYPE: Method
  * NAME: loadModel
  * USAGE: It is used to load a deep learning model
  * */
  Future loadModel(model) async {
    Tflite.close();

    try {
      String res;

      switch (model) {
        case "model0":
          res = await Tflite.loadModel(
              model: "assets/models/model.tflite",
              labels: "assets/models/labels.txt");
          break;
        default:
          res = await Tflite.loadModel(
              model: "assets/models/model1.tflite",
              labels: "assets/models/labels1.txt");
      }
    } on PlatformException {
        print('Failed to load model.');
    }
  }

  /*
  * TYPE: Method
  * NAME: runModelOnImage
  * USAGE: It is used to analyse the image and classify it as infected and uninfected
  * */
  Future<Diagnosis> runModelOnImage(File image) async {
    await loadModel("model1");

    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        imageStd: 127.5,
        imageMean: 127.5,
        threshold: 0.5
    );

    diagnosis.image = image;
    diagnosis.result = output[0]['label'].substring(1);
    diagnosis.confidence = "${output[0]['confidence'] * 100}%";

    return diagnosis;
  }
}
