
import 'dart:ui' as ui;
import 'package:facite_alumnos/models/ModelActividades.dart';
import 'package:facite_alumnos/models/ModelArchivos.dart';
import 'package:facite_alumnos/models/ModelCreditos.dart';
import 'package:facite_alumnos/utils/actividadDetails.dart';
import 'package:facite_alumnos/utils/actividadesList.dart';
import 'package:facite_alumnos/utils/archivoDetails.dart';
import 'package:facite_alumnos/utils/archivosList.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:facite_alumnos/globals.dart' as globals;
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:rflutter_alert/rflutter_alert.dart';


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
      home: new MyHomePage(title: 'Alumnos FACITE APP'),
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

    //para los archivos
    var urlArchivos = "http://facite.uas.edu.mx/alumnos/api/api_get_archivos.php?cuenta=" + "${globals.cuenta}";
    ModelArchivos archivos;
    List<FACITEAPP_ARCHIVOS> archivos_list;

    int currentPage = 0;

    GlobalKey bottomNavigationKey = GlobalKey();

    @override
      void initState() {
        super.initState();
        obtenerCreditos();
        obtenerActividades();
        obtenerArchivos();
        //print(url);
      }

    obtenerCreditos() async {
    var res = await http.get(url);
      //print(res.body);
      var decodedJSON = jsonDecode(res.body);
      creditos = ModelCreditos.fromJson(decodedJSON);
      //print(home.toJson());
      actividad = creditos.fACITEAPP.toList();
      /*setState(() {
        actividad = creditos.fACITEAPP.toList();
      });*/
    }

    obtenerActividades() async {
    var res = await http.get(url_a);
      //print(res.body);
      var decodedJSON = jsonDecode(res.body);
      actividades = ModelActividades.fromJson(decodedJSON);
      //print(home.toJson());
      actividad_a = actividades.fACITEAPP.toList();
      /*setState(() {
        actividad_a = actividades.fACITEAPP.toList();
      });*/
    }

    obtenerArchivos() async {
    var res = await http.get(urlArchivos);
      var decodedJSON = jsonDecode(res.body);
      archivos = ModelArchivos.fromJson(decodedJSON);
      //print(archivos.toJson());
      archivos_list = archivos.fACITEAPP.toList();
      /*setState(() {
        archivos_list = archivos.fACITEAPP.toList();
      });*/
    }
 
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Stack(
        fit: StackFit.expand,
        children: <Widget>[

          new Image.asset('assets/img/bg.png', fit: BoxFit.cover,),
          //new Image.network('http://facite.uas.edu.mx/alumnos/api/img/bg.png', fit: BoxFit.cover,),
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
                    padding: const EdgeInsets.all(0.0),
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
                              image: NetworkImage("http://facite.uas.edu.mx/alumnos/images/default.png"),
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
              }),
              
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
              <li>Consultar las actividades de libre elección disponibles</li>
							<li>Ver tu historial de créditos acumulados.</li>
							<li>Ver el estado de tus documentos enviados.</li>
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
        //obtener Actividades
        return 
              actividad_a == null ? Center(child: CircularProgressIndicator(),) : 
              ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(5.0),
                  scrollDirection: Axis.vertical,
                  primary: true,
                  itemCount: actividad_a.length,
                  itemBuilder: (BuildContext content, int index) {
                     return new InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (context) {
                              return new ActividadDetail(nombre: actividad_a[index].nombreActividad, definicion: actividad_a[index].definicion, categoria: actividad_a[index].categoria, creditos: actividad_a[index].creditos, creditosmax: actividad_a[index].creditosmax, creditosmin: actividad_a[index].creditosmin, evidencias: actividad_a[index].evidencias,);
                            },
                          ),
                        );
                      },
                    child: new Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 5),
                          child: ActividadesList(
                          title: actividad_a[index].nombreActividad,
                          content: actividad_a[index].definicion,
                          
                          ),
                    ));
                  },
                );
        
          case 2:
            //obtenerCreditos();
            return Container(
              child: actividad == null ? Center(child: CircularProgressIndicator(),) : 
                Center(child: 
                Column(
                  children: <Widget>[
                    new Text("${actividad[0].creditos}",
                            textAlign: TextAlign.center,
                            textScaleFactor: 14,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey),
                          ),
                          new Divider(color: Colors.blueGrey,),
                    new Text("Créditos Acumulados",
                            textAlign: TextAlign.center,
                            textScaleFactor: 1.2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey),
                    ),
                    new Divider(color: Colors.blueGrey,),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: new Html(data: """<blockquote>
                        ${actividad[0].historial}</blockquote>
                      """,
                        linkStyle: const TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    )
                  ],
                )
                ),
            );
            case 3:
              //obtenerArchivos();
              return archivos == null ? Center(child: CircularProgressIndicator(),) :
              ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(5.0),
                scrollDirection: Axis.vertical,
                primary: true,
                // Let the ListView know how many items it needs to build
                itemCount: archivos_list.length,
                // Provide a builder function. This is where the magic happens! We'll
                // convert each item into a Widget based on the type of item it is.
                 itemBuilder: (BuildContext content, int index) {
                   return new InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ArchivoDetail(
                                      contenido: archivos_list[index].descripcion,
                                      url: archivos_list[index].url_doc,
                                      estado: archivos_list[index].estado,
                                      nombre: archivos_list[index].nombre_doc,
                                      observaciones: archivos_list[index].observaciones,
                                  )));
                      },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 5),
                            child: ArchivosListItem(
                            title: archivos_list[index].nombre_doc,
                            content: archivos_list[index].descripcion, 
                            estado: archivos_list[index].estado,
                            tipo: archivos_list[index].tipo_doc,
                            url : archivos_list[index].url_doc,
                            observaciones: archivos_list[index].observaciones,
                          ),
                    ));
                  },
                );
      }
  }
}





