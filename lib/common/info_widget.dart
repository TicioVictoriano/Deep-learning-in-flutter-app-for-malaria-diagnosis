import "package:flutter/material.dart";

/*
  * TYPE: Template Class
  * NAME: InfoWidget
  * USAGE: It is used as a template for creating cards in the homeview
  * */
class InfoWidget extends StatelessWidget {
  final String label, value;
  final Icon icon;

  const InfoWidget({Key key, this.label, this.value, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
      child: Card(
        elevation: 12,
        child: Container(
            width: 50,
            height: 55,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    icon,
                    Text(" " + label,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.orange),
                        textAlign: TextAlign.center),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: value == null
                      ? Text("")
                      : Text(" " + value,
                          style: TextStyle(
                              fontSize: 10.5, fontWeight: FontWeight.bold)),
                )
              ],
            )),
      ),
    );
  }
}
