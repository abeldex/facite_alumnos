import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ActividadDetail extends StatefulWidget {
    final String nombre;
    final String definicion;
    final String categoria;
    final String creditos;
    final String creditosmax;
    final String creditosmin;
    final String evidencias;
  //final String url;

  ActividadDetail({this.nombre, this.definicion, this.categoria, this.creditos, this.creditosmax, this.creditosmin, this.evidencias});
  
  @override
  _ActividadDetail createState() => new _ActividadDetail( nombre: nombre, definicion: definicion, categoria: categoria, creditos: creditos, creditosmax: creditosmax, creditosmin: creditosmin, evidencias: evidencias );

}

class _ActividadDetail extends State<ActividadDetail> {
    final String nombre;
    final String definicion;
    final String categoria;
    final String creditos;
    final String creditosmax;
    final String creditosmin;
    final String evidencias;

   _ActividadDetail({this.nombre, this.definicion, this.categoria, this.creditos, this.creditosmax, this.creditosmin, this.evidencias});
      
   @override
      void initState() {
        super.initState();
    }

    Widget _buildContent(BuildContext context) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              
              //_buildAvatar(),
              _buildInfo(context),
              
            ],
            
          ),
        );
      }

      Widget _buildAvatar() {
        return Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white30),
          ),
          margin: const EdgeInsets.only(top: 40.0, left: 5.0),
          padding: const EdgeInsets.all(3.0),
          /*child: ClipOval(
            child: SvgPicture.network("https://image.flaticon.com/icons/svg/1039/1039328.svg"),
            //Image.network("https://cdn1.iconfinder.com/data/icons/filetype-4/48/filetype_-_pdf-128.png"), 
          ),*/
          
        );
      }

      Widget _buildInfo(BuildContext context) {
        return Container(
          margin: const EdgeInsets.only(top: 50.0, left: 5.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[     
                Text(
                  nombre,
                  style: TextStyle(
                    color: Colors.amber[200],
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                  
                ),
                 Container(
                  color: Colors.white.withOpacity(0.85),
                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                  width: 350.0,
                  height: 1.0,
                ),
                Html(
                  data: "<table><tr><td>Credito(s) por evento: </td><td>"+creditos+"</td></tr><tr><td>Creditos Máximos: </td><td>"+creditosmax+" créditos</td></tr></table>",
                  defaultTextStyle: TextStyle( color: Colors.white,
                    height: 1.4, fontSize: 16),
                ),
               Text("Definicion: " ,
                    style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.amber[200],
                        fontWeight: FontWeight.w800,
                      ),),
                Card(
                   shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: new Column(
                  children: <Widget>[
                    
                  
                   Html(
                        data: definicion,
                        defaultTextStyle: TextStyle(color: Colors.blueGrey,
                    height: 1.4, fontSize: 16, ),
                    ),   
                    Container(
                  color: Colors.white.withOpacity(0.85),
                  margin: const EdgeInsets.symmetric(vertical: 16.0),
                  width: 350.0,
                  height: 1.0,
                )],
                )),        
                    Text("Evidencias: " ,
                style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.amber[200],
                    fontWeight: FontWeight.w800,
                  ),),
                    Card(
                   shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: new Column(
                  children: <Widget>[
                    
                  
                   Html(
                        data: evidencias,
                        defaultTextStyle: TextStyle(color: Colors.blueGrey,
                    height: 1.4, fontSize: 16, ),
                    ),   
                    Container(
                  color: Colors.white.withOpacity(0.85),
                  margin: const EdgeInsets.symmetric(vertical: 16.0),
                  width: 350.0,
                  height: 1.0,
                )],
                )),        
                    
                    ], 
            ),    
          ),
        );
        
      }

         @override
      Widget build(BuildContext context) {
        return Scaffold(
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
          child: AppBar(title: Text(""),
            backgroundColor: Colors.transparent, //No more green
            elevation: 0.0, //Shadow gone
          ),),   
            ],
            
          ),
          
          //bottomNavigationBar: _buildBottomNavigationBar(context),
        );
      }


}