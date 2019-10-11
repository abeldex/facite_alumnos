import 'package:facite_alumnos/utils/archivoDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ArchivosListItem extends StatefulWidget {
  final String title;
  final String content;
  final String estado;
  final String tipo;
  final String url;
  final String observaciones;

  ArchivosListItem({this.title, this.content, this.estado, this.tipo, this.url, this.observaciones});

  @override
  _ArchivosListItemListItemState createState() => new _ArchivosListItemListItemState();
}

class _ArchivosListItemListItemState extends State<ArchivosListItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: 
      CircleAvatar(
        radius: 30.0,
        backgroundColor: Colors.transparent,  
        child:
        SvgPicture.asset("assets/img/pdf.svg"))/*CircleAvatar(
        radius: 30.0,
         backgroundImage: NetworkImage('https://cdn1.iconfinder.com/data/icons/filetype-4/48/filetype_-_pdf-128.png'),
         backgroundColor: Colors.transparent,  
        /*Text(widget.tipo)*/
      )*/,
      title: Text(widget.title, 
      style:  TextStyle(
        color: Colors.blueGrey,
        fontSize: 14, fontWeight: FontWeight.w500
      )),
      subtitle: Padding(
        padding: const EdgeInsets.only(top:5.0),
        child: Text(
                       "Estado: (" + widget.estado.toUpperCase() + ")",
                       textAlign: TextAlign.left,
                        style: TextStyle(color: widget.estado == 'aprobado' ? Colors.green : (widget.estado == 'rechazado' ? Colors.red : Colors.grey), fontSize: 12.0, fontWeight: FontWeight.w500),
                    ),
      ),
      trailing: Icon(Icons.keyboard_arrow_right),
      
      /*onTap: () {
        // abriremos los detalles del documento
        //print(widget.content);
         Navigator.push(context, MaterialPageRoute(builder: (context)=>ArchivoDetail(
                                      contenido: widget.content,
                                      url: widget.url,
                                      estado: widget.estado,
                                      nombre: widget.title,
                                      observaciones: widget.observaciones,
                                  )));
      },*/
    );
  }
}
