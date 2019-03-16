class ModelActividades {
  List<FACITEAPP> fACITEAPP;

  ModelActividades({this.fACITEAPP});

  ModelActividades.fromJson(Map<String, dynamic> json) {
    if (json['FACITE_APP'] != null) {
      fACITEAPP = new List<FACITEAPP>();
      json['FACITE_APP'].forEach((v) {
        fACITEAPP.add(new FACITEAPP.fromJson(v));
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

class FACITEAPP {
  String idActividad;
  String nombreActividad;
  String definicion;

  FACITEAPP({this.idActividad, this.nombreActividad, this.definicion});

  FACITEAPP.fromJson(Map<String, dynamic> json) {
    idActividad = json['id_actividad'];
    nombreActividad = json['nombre_actividad'];
    definicion = json['definicion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_actividad'] = this.idActividad;
    data['nombre_actividad'] = this.nombreActividad;
    data['definicion'] = this.definicion;
    return data;
  }
}