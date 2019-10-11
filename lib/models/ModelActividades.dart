class ModelActividades {
  List<FACITEAPP_ACT> fACITEAPP;

  ModelActividades({this.fACITEAPP});

  ModelActividades.fromJson(Map<String, dynamic> json) {
    if (json['FACITE_APP'] != null) {
      fACITEAPP = new List<FACITEAPP_ACT>();
      json['FACITE_APP'].forEach((v) {
        fACITEAPP.add(new FACITEAPP_ACT.fromJson(v));
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

class FACITEAPP_ACT {
  String idActividad;
  String nombreActividad;
  String definicion;
  String categoria;
  String creditos;
  String creditosmax;
  String creditosmin;
  String evidencias;

  FACITEAPP_ACT({this.idActividad, this.nombreActividad, this.definicion, this.categoria, this.creditos, this.creditosmax, this.creditosmin, this.evidencias});

  FACITEAPP_ACT.fromJson(Map<String, dynamic> json) {
    idActividad = json['id_actividad'];
    nombreActividad = json['nombre_actividad'];
    definicion = json['definicion'];
    categoria = json['categoria'];
    creditos = json['creditos'];
    creditosmax = json['creditosmax'];
    creditosmin = json['creditosmin'];
    evidencias = json['evidencias'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_actividad'] = this.idActividad;
    data['nombre_actividad'] = this.nombreActividad;
    data['definicion'] = this.definicion;
    data['categoria'] = this.categoria;
    data['creditos'] = this.creditos;
    data['creditosmax'] = this.creditosmax;
    data['creditosmin'] = this.creditosmin;
    data['evidencias'] = this.evidencias;
    return data;
  }
}