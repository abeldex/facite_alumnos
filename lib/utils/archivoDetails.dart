import 'dart:io';
import 'dart:ui' as ui;
import 'package:facite_alumnos/utils/PDFScreen.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ArchivoDetail extends StatefulWidget {
  final String nombre;
    final String estado;
    final String contenido;
    final String url;
    final String observaciones;
  //final String url;

  ArchivoDetail({this.contenido, this.url, this.nombre, this.estado, this.observaciones});
  
  @override
  _ArchivoDetail createState() => new _ArchivoDetail( contenido: contenido, url: url, nombre: nombre, estado:estado , observaciones : observaciones );

}

class _ArchivoDetail extends State<ArchivoDetail> {
    final String nombre;
    final String estado;
    final String contenido;
    final String url;
    final String observaciones;
   _ArchivoDetail({this.contenido, this.url, this.nombre, this.estado, this.observaciones});
   
   String pathPDF = "";
   
   @override
      void initState() {
        super.initState();
        bajarArchivo().then((f) {
          setState(() {
            pathPDF = f.path;
            print(pathPDF);
            //Navigator.pop(context);
            //Navigator.push(context,MaterialPageRoute(builder: (context) => PDFScreen(pathPDF, rev.bookTitle)),);
          });
        });
    }

    Future<File> bajarArchivo() async {
    //final url = "${url}";
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
        File file = new File('$dir/$filename');
        await file.writeAsBytes(bytes);
        return file;
    }

    Widget _buildContent(BuildContext context) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              
              _buildAvatar(),
              _buildInfo(context),
              
            ],
            
          ),
        );
      }

      Widget _buildAvatar() {
        return Container(
          width: 110.0,
          height: 110.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white30),
          ),
          margin: const EdgeInsets.only(top: 32.0, left: 16.0),
          padding: const EdgeInsets.all(3.0),
          child: ClipOval(
            child: SvgPicture.asset("assets/img/pdf.svg"),
            
          ),
          
        );
      }

      Widget _buildInfo(BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[ 
                    RaisedButton(
                onPressed: ()  => pathPDF == "" ?   Alert(
                      context: context,
                      //type: AlertType.info,
                      title: "Descargando documento...",
                      desc: "Espere unos segundos por favor",
                      image: Image.network("http://190.107.23.94:807/BPM_Conservatorio/App_Themes/AzulCielo/Imagenes/procesando.gif", width: 50,),
                      buttons: [
                        DialogButton(
                          child: Text(
                            "Muy bien!",
                            style: TextStyle(color: Colors.white, fontSize: 20,),
                          ),
                           onPressed: () => Navigator.pop(context),
                          width: 140,
                        ),
                       
                      ],
                    ).show() 
                    : Navigator.push(context,MaterialPageRoute(builder: (context) => PDFScreen(pathPDF, nombre)),),
                color: Colors.blueGrey,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.picture_as_pdf,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      Text(
                        "ABRIR DOCUMENTO",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              /*Text(
                nombre ,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
              ),*/
              Text(
                "Estado : [ " + estado + " ] ",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white.withOpacity(0.85),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                color: Colors.white.withOpacity(0.85),
                margin: const EdgeInsets.symmetric(vertical: 16.0),
                width: 350.0,
                height: 1.0,
              ),
              Text("Descripcion: " ,
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white.withOpacity(0.85),
                  fontWeight: FontWeight.w500,
                ),),
              Html(
                      data: contenido,
                      defaultTextStyle: TextStyle( color: Colors.white.withOpacity(0.85),
                  height: 1.4, fontSize: 16),
                  ),
                   Container(
                color: Colors.white.withOpacity(0.85),
                margin: const EdgeInsets.symmetric(vertical: 16.0),
                width: 350.0,
                height: 1.0,
              ),
              Text("Observaciones: " ,
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white.withOpacity(0.85),
                  fontWeight: FontWeight.w500,
                ),),
                 Html(
                      data: observaciones,
                      defaultTextStyle: TextStyle( color: Colors.white.withOpacity(0.85),
                  height: 1.4, fontSize: 16),
                  ),           
                  ],
          ),
          
        );
        
      }

         @override
      Widget build(BuildContext context) {
        return Scaffold(
          /*appBar: new AppBar(
            flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.black,
          ),
        ),
        brightness: Brightness.dark,
            automaticallyImplyLeading: true,
            //`true` if you want Flutter to automatically add Back Button when needed,
            //or `false` if you want to force your own back button every where
            title: Text('$nombre'),
            leading: IconButton(icon:Icon(Icons.arrow_back),
              onPressed:() => Navigator.pop(context, false),
            )
          ),*/
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              new Image.asset('assets/img/bg.png', fit: BoxFit.cover,),
             //Image.asset('assets/img/blue_bg.png', fit: BoxFit.cover,),
              BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                child: Container(
                  color: Colors.black.withOpacity(0.0),
                  child: _buildContent(context),     
                ),
                
              ),  
              new Positioned( //Place it at the top, and not use the entire screen
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: AppBar(title: Text(nombre),
            backgroundColor: Colors.transparent, //No more green
            elevation: 0.0, //Shadow gone
          ),),   
            ],
            
          ),
          
          //bottomNavigationBar: _buildBottomNavigationBar(context),
        );
      }


}