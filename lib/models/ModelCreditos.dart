class ModelCreditos {
  List<FACITEAPP> fACITEAPP;

  ModelCreditos({this.fACITEAPP});

  ModelCreditos.fromJson(Map<String, dynamic> json) {
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
  String cuenta;
  String creditos;

  FACITEAPP({this.cuenta, this.creditos});

  FACITEAPP.fromJson(Map<String, dynamic> json) {
    cuenta = json['cuenta'];
    creditos = json['creditos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cuenta'] = this.cuenta;
    data['creditos'] = this.creditos;
    return data;
  }
}