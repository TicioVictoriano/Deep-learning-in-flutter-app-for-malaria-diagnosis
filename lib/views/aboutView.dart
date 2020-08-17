import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:prototype/common/info_widget.dart';
import 'package:prototype/controllers/homeController.dart';
import 'package:prototype/models/diagnosis.dart';

class HomeView extends StatefulWidget {
  String title;

  HomeView({Key key, this.title}) : super(key: key);

  @override
  HomeViewState createState() => HomeViewState(title);
}

/*
  * TYPE:  State class for the HomeView
  * NAME:  HomeViewState
  * USAGE: This class is responsible for creating and managing the state of the HomeView interface.
  * */
class HomeViewState extends State<HomeView> {
  bool camera = false;
  String _title;
  HomeController _controller = new HomeController();
  Diagnosis diagnosis;
  bool _isLoading = true;

  HomeViewState(this._title);

  /*
  * TYPE:  Method
  * NAME:  build
  * USAGE: This method is used to build the user interface for the homeview page.
  * */
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    final drawerHeader = UserAccountsDrawerHeader(
      accountName: Text("Developed by: Tício Victoriano"),
      accountEmail: Text("Email: tvictoriano16@.alustudent.com"),
      currentAccountPicture: CircleAvatar(
        child: FlutterLogo(size: 42.0,),
        backgroundColor: Colors.white,
      ),
    );


//    DrawerHeader(
//      child: ListView(
//        children: <Widget>[
//          CircleAvatar(
//            child: FlutterLogo(size: 65.0,),
//            backgroundColor: Colors.white,
//          ),
//        ],
//      ),
//    );



    final drawerItems = ListView(
      children: <Widget>[
        Container(
            child: drawerHeader,
            color: Colors.brown,
        ),
        ListTile(
          title: Text("saved results"),
          onTap: () => Container(child: Center(child: Text("ola 2"),),),
        ),
        ListTile(
          title: Text("About the app"),
          onTap: () => Container(child: Center(child: Text("ola 2"),),),
        ),

      ],
    );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45),
        child: AppBar(
          title: Text(_title, textAlign: TextAlign.center),
          centerTitle: true,
          backgroundColor: Colors.black54,
        ),
      ),
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            return ListView(
              children: <Widget>[
                new Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: orientation == Orientation.portrait
                          ? screenHeight * 0.2
                          : screenWidth * 0.5,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/image-2.png"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(3),
                            bottomLeft: Radius.circular(3)),
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 12, bottom: 3),
                            child: Icon(
                              Icons.bubble_chart,
                              size: 38,
                              color: Colors.white,
                            ),
                          ),
                          const Text("Malaria diagnosis",
                              style: TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.1),
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: orientation == Orientation.portrait
                              ? screenHeight * 0.15
                              : screenHeight * 0.5,
                          left: 25,
                          right: 25),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InfoWidget(
                              label: "Result",
                              value: _controller.diagnosis.result,
                              icon: Icon(Icons.insert_chart,
                                  size: 16, color: Colors.orange)),
                          InfoWidget(
                            label: "Confidence",
                            value: _controller.diagnosis.confidence,
                            icon: Icon(Icons.pie_chart,
                                size: 16, color: Colors.orange),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                _isLoading
                    ? Container(
                        width: screenWidth,
                        height: screenHeight * 0.5,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: <Widget>[
                          Container(
                              width: double.infinity,
                              height: orientation == Orientation.portrait
                                  ? screenHeight / 2
                                  : screenHeight,
                              padding: EdgeInsets.only(
                                  top: 20, bottom: 8, left: 29, right: 29),
                              child: _controller.diagnosis.image == null
                                  ? Container()
                                  : FittedBox(
                                      child: Image.file(
                                          _controller.diagnosis.image),
                                      fit: BoxFit.fill)),
                          _controller.diagnosis.result == null
                              ? Text("")
                              : orientation == Orientation.portrait
                                  ? Text(_controller.diagnosis.result + "\n ",
                                      style: TextStyle(
                                        color: _controller.diagnosis.result
                                                .contains("uninfected")
                                            ? Colors.green
                                            : Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ))
                                  : Text("")
                        ],
                      ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown,
        tooltip: "click to select an image",
        child: Icon(Icons.image),
//        mini: true,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Container(
                    height: screenHeight / 5,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 10, bottom: 10, left: 7, right: 7),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Would like to get the image from:",
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: Row(children: <Widget>[
                              Expanded(
                                  child: RaisedButton(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.image,
                                        size: 17,
                                        color: Colors.white,
                                      ),
                                      Text("Gallery",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14))
                                    ]),
                                onPressed: () {
                                  camera = false;
                                  setState(() {
                                    _isLoading = true;
                                  });

                                  _controller
                                      .selectDiagnosisImage(camera)
                                      .then((image) {
                                    image == null
                                        ? setState(() {
                                            _isLoading = false;
                                          })
                                        : _controller
                                            .runModelOnImage(image)
                                            .then((data) {
                                            setState(() {
                                              diagnosis = data;
                                              _isLoading = false;
                                            });
                                          });
                                  });

                                  Navigator.pop(context);
                                },
                                color: Colors.amber,
                                disabledColor: Colors.amber,
                              )),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                  child: RaisedButton(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.camera,
                                        size: 17,
                                        color: Colors.white,
                                      ),
                                      Text("Camera ",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14))
                                    ]),
                                onPressed: () {
                                  camera = true;

                                  _controller
                                      .selectDiagnosisImage(camera)
                                      .then((image) {
                                    image == null
                                        ? setState(() {
                                            _isLoading = false;
                                          })
                                        : _controller
                                            .runModelOnImage(image)
                                            .then((data) {
                                            setState(() {
                                              diagnosis = data;
                                              _isLoading = false;
                                            });
                                          });
                                  });

                                  Navigator.pop(context);
                                },
                                color: Colors.blue,
                                disabledColor: Colors.blue,
                              ))
                            ]),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      drawer: Drawer(
        child: drawerItems
      )
    );
  }

  /*
  * TYPE:  Method
  * NAME:  initState
  * USAGE: This method is used to initialize the homeview when it first presented in the smartphone screen
  * */
  @override
  void initState() {
    super.initState();
    diagnosis = new Diagnosis();
    _isLoading = false;
  }
}
