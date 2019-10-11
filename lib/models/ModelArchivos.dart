class ModelArchivos {
  List<FACITEAPP_ARCHIVOS> fACITEAPP;

  ModelArchivos({this.fACITEAPP});

  ModelArchivos.fromJson(Map<String, dynamic> json) {
    if (json['FACITE_APP'] != null) {
      fACITEAPP = new List<FACITEAPP_ARCHIVOS>();
      json['FACITE_APP'].forEach((v) {
        fACITEAPP.add(new FACITEAPP_ARCHIVOS.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fACITEAPP != null) {
      data['FACITE_APP'] = this.fACITEAPP.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FACITEAPP_ARCHIVOS {
  String id_registro;
  String actividad;
  String nombre_doc;
  String url_doc;
  String estado;
  String tipo_doc;
  String descripcion;
  String observaciones;


  FACITEAPP_ARCHIVOS({this.id_registro, this.actividad, this.nombre_doc, this.url_doc, this.estado, this.tipo_doc, this.descripcion, this.observaciones});

  FACITEAPP_ARCHIVOS.fromJson(Map<String, dynamic> json) {
    id_registro = json['id_registro'];
    actividad = json['actividad'];
    nombre_doc = json['nombre_doc'];
    url_doc = json['url_doc'];
    estado = json['estado'];
    tipo_doc = json['tipo_doc'];
    descripcion = json['descripcion'];
    observaciones = json['observaciones'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_registro'] = this.id_registro;
    data['actividad'] = this.actividad;
    data['nombre_doc'] = this.nombre_doc;
    data['url_doc'] = this.url_doc;
    data['estado'] = this.estado;
    data['tipo_doc'] = this.tipo_doc;
    data['descripcion'] = this.descripcion;
    data['observaciones'] = this.observaciones;
    return data;
  }
}