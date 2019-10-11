import 'package:flutter/material.dart';

class ActividadesList extends StatefulWidget {
  String title;
  String content;


  ActividadesList({this.title, this.content});

  @override
  _ActividadesListState createState() => new _ActividadesListState();
}

class _ActividadesListState extends State<ActividadesList> {
  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Expanded(
          child: new Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  widget.title,
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: new Text(
                    widget.content,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                        fontWeight: FontWeight.normal,),
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ],
    );
  }
}
