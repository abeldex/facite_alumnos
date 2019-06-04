
import 'dart:ui' as ui;
import 'package:facite_alumnos/models/ModelActividades.dart';
import 'package:facite_alumnos/models/ModelCreditos.dart';
import 'package:facite_alumnos/pages/actividades.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:facite_alumnos/globals.dart' as globals;
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Facite Alumnos',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: new MyHomePage(title: 'Actividades de Libre Eleccion'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    //para los creditos
    var url = "http://facite.uas.edu.mx/alumnos/api/ap_get_creditos.php?cuenta=" + "${globals.cuenta}";
    
    ModelCreditos creditos;
    List<FACITEAPP> actividad;

    //para las actividades
    var url_a = "http://facite.uas.edu.mx/alumnos/api/api_get_actividades.php";
    ModelActividades actividades;
    List<FACITEAPP_ACT> actividad_a;

    int currentPage = 0;

    GlobalKey bottomNavigationKey = GlobalKey();

    @override
      void initState() {
        super.initState();
        obtenerDatos();
        obtenerActividades() ;
        //print(url);
      }

    obtenerDatos() async {
    var res = await http.get(url);
      print(res.body);
      var decodedJSON = jsonDecode(res.body);
      creditos = ModelCreditos.fromJson(decodedJSON);
      //print(home.toJson());
      setState(() {
        actividad = creditos.fACITEAPP.toList();
      });
    }

    obtenerActividades() async {
    var res = await http.get(url_a);
      //print(res.body);
      var decodedJSON = jsonDecode(res.body);
      actividades = ModelActividades.fromJson(decodedJSON);
      //print(home.toJson());
      setState(() {
        actividad_a = actividades.fACITEAPP.toList();
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
              child: creditos == null ? Center(child: CircularProgressIndicator(),) : Card(
                
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: 
                  _getPage(currentPage),
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
         ]
      ),    
      bottomNavigationBar: FancyBottomNavigation(
       tabs: [
                      TabData(iconData: Icons.home, title: "Inicio",  onclick: () {
                        final FancyBottomNavigationState fState =
                            bottomNavigationKey.currentState;
                        fState.setPage(0);
                      }),
                      TabData(iconData: Icons.receipt, title: "Actividades",  onclick: () {
                final FancyBottomNavigationState fState =
                    bottomNavigationKey.currentState;
                fState.setPage(1);
              }),
                      TabData(iconData: Icons.check_circle, title: "Creditos",  onclick: () {
                final FancyBottomNavigationState fState =
                    bottomNavigationKey.currentState;
                fState.setPage(2);
              }),
                      TabData(iconData: Icons.insert_drive_file, title: "Documentos",  onclick: () {
                final FancyBottomNavigationState fState =
                    bottomNavigationKey.currentState;
                fState.setPage(3);
              })
                  ],
        initialSelection: 0,
        key: bottomNavigationKey,
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
          });
        },
      )
    ), ],
      )
    );
  }

  _getPage(int page) {
    switch (page) {
      case 0:
        return Stack(
        children: <Widget>[
          new Card(
            color: Colors.white,
            child: new SingleChildScrollView(
              child: new Html(
                data: """
                <img src="https://media.istockphoto.com/vectors/people-and-education-group-of-happy-students-with-books-vector-id639973478?k=6&m=639973478&s=612x612&w=0&h=N1-F692LMKhChk4KLo7usueIrbO0jBXfrbEopAbyl-Q=">
               <div class="col-md my-auto"><!-- .my-auto vertically centers contents -->
               <h2>Bienvenidos al Sistema Integral para Alumnos de la FACITE!</h2>
						<p>Si eres estudiante del nivel profesional en la UAS, aquí deberás subir los documentos que acrediten tus Actividades de Libre Elección, las cuales deberás cumplir durante toda tu carrera profesional. </p>
						<p>Desde aquí podrás:</p>
						<ul>
							<li>Subir nuevos documentos acreditables.</li>
							<li>Ver tu historial de créditos acumulados.</li>
							<li>Verificar tus créditos por cumplir.</li>
							<li>Descargar tus documentos probatorios.</li>
						</ul>
            <p></p>
						<h3>Nota: </h3>
						<p>Si aún no tienes los datos de acceso, los puedes solicitar en el Depto. de Control Escolar de tu escuela o facultad.</p>
						<div style="height:15px;"></div>
						<!--<p><a class="btn btn-green-pro" href="signup-step1.html" role="button">Learn More</a></p>-->
					</div>

                """,
                padding: EdgeInsets.all(40.0),
                onLinkTap: (url) {
                  print("Opening $url...");
                },
                customRender: (node, children) {
                  if (node is dom.Element) {
                    switch (node.localName) {
                      case "custom_tag": // using this, you can handle custom tags in your HTML 
                        return Column(children: children);
                    }
                  }
                }),
            )
          )
        ],
      );
      case 1:
        return 
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Transform.translate(
              offset: new Offset(0.0, MediaQuery.of(context).size.height * 0.08),
              child: actividad_a == null ? Center(child: CircularProgressIndicator(),) : ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(0.0),
                  scrollDirection: Axis.vertical,
                  primary: true,
                  itemCount: actividad.length,
                  itemBuilder: (BuildContext content, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 5),
                                        child: AwesomeListItem(
                          title: actividad_a[index].nombreActividad,
                          content: actividad_a[index].definicion
                          ),
                    );
                  },
                ),
            );
      default:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Creditos"),
            RaisedButton(
              child: Text(
                "Creditos",
                style: TextStyle(color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () {},
            )
          ],
        );
    }
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


