import 'dart:ui' as ui;
import 'package:facite_alumnos/models/ModelActividades.dart';
import 'package:facite_alumnos/utils/actividadesList.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:facite_alumnos/globals.dart' as globals;

class ActividadesPage extends StatefulWidget {
  ActividadesPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ActividadesPageState createState() => new _ActividadesPageState();
}

class _ActividadesPageState extends State<ActividadesPage> {
    var url = "http://facite.uas.edu.mx/alumnos/api/api_get_actividades.php";
    ModelActividades actividades;
    List<FACITEAPP_ACT> actividad;
    
    int currentPage = 0;
    GlobalKey bottomNavigationKey = GlobalKey();

    @override
      void initState() {
        super.initState();
        obtenerDatos();
      }

    obtenerDatos() async {
    var res = await http.get(url);
      //print(res.body);
      var decodedJSON = jsonDecode(res.body);
      actividades = ModelActividades.fromJson(decodedJSON);
      //print(home.toJson());
      setState(() {
        actividad = actividades.fACITEAPP.toList();
      });
    }
 
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Stack(
        fit: StackFit.expand,
        children: <Widget>[

          new Image.asset('assets/img/blue_bg.png', fit: BoxFit.cover,),
          //new Image.network('http://facite.uas.edu.mx/alumnos/images/slide3.png', fit: BoxFit.cover,),
          
          new Scaffold(
            appBar: new AppBar(
              
              title: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Image.asset('assets/img/loguito.png',
                      fit: BoxFit.contain,
                      height: 32,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                          child: Text(widget.title,
                          style: TextStyle(color: Colors.white,  shadows: <Shadow>[
                            Shadow(
                              offset: Offset(1, 1),
                              blurRadius: 6.0,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ],),
                    ),
                  ),
                 ],
              ),
              elevation: 0.0,
              backgroundColor: const Color(0xFFB4C56C).withOpacity(0.0),
            ),
            backgroundColor: Colors.transparent,
            body: new Stack(
        children: <Widget>[
          new BackdropFilter(
                filter: new ui.ImageFilter.blur(
                  sigmaX: 0.0,
                  sigmaY: 0.0,
                ),
                      child: new Transform.translate(
              offset: new Offset(0.0, MediaQuery.of(context).size.height * 0.08),
              child: actividades == null ? Center(child: CircularProgressIndicator(),) : Card(
                
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
                  child: new ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(0.0),
                  scrollDirection: Axis.vertical,
                  primary: true,
                  itemCount: actividad.length,
                  itemBuilder: (BuildContext content, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 5),
                                        child: ActividadesList(
                          title: actividad[index].nombreActividad,
                          content: actividad[index].definicion
                          ),
                    );
                  },
                ),
              ),
            ),
          ),

          new Transform.translate(
            offset: Offset(0.0, -56.0),
            
            child: new Container(
              height: 100.00,
              child: new Stack(
                children: [
                  
                  new Opacity(
                    opacity: 0.2,
                    child: new Container(color: Colors.transparent,),
                  ),
                  new Transform.translate(
                    offset: Offset(0.0, 40.0),
                    child: 
                    new ListTile(
                      leading: new CircleAvatar(
                        child: new Container(
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                            image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  "http://facite.uas.edu.mx/alumnos/images/default.png"),
                            ),
                          ),
                        ),
                      ),
                      title: new Text(
                        "${globals.nombre}",
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            shadows: <Shadow>[
                      Shadow(
                        offset: Offset(1, 1),
                        blurRadius: 6.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ],
    ),
                      ),
                      subtitle: new Text(
                        "${globals.cuenta}",
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontStyle: FontStyle.normal, shadows: <Shadow>[
                      Shadow(
                        offset: Offset(1, 1),
                        blurRadius: 6.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ],),
                      ),
                    ),
                    
                  ),
                ],
                
              ),
              
            ),
          )
        ],
      ),
          bottomNavigationBar: FancyBottomNavigation(
                  tabs: [
                      TabData(iconData: Icons.home, title: "Inicio"),
                      TabData(iconData: Icons.receipt, title: "Actividades"),
                      TabData(iconData: Icons.check_circle, title: "Creditos"),
                      TabData(iconData: Icons.insert_drive_file, title: "Documentos")
                  ],
                  onTabChangedListener: (position) {
                      setState(() {
                      currentPage = position;
                      });
                  },
              ),             
          ),
        ],
      )
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = new Path();
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width, size.height / 4.75);
    p.lineTo(0.0, size.height / 3.75);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

