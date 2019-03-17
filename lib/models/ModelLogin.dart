class ModelLogin {
  List<FACITEAPP> fACITEAPP;

  ModelLogin({this.fACITEAPP});

  ModelLogin.fromJson(Map<String, dynamic> json) {
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
  String name;
  String success;

  FACITEAPP({this.cuenta, this.name, this.success});

  FACITEAPP.fromJson(Map<String, dynamic> json) {
    cuenta = json['cuenta'];
    name = json['name'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cuenta'] = this.cuenta;
    data['name'] = this.name;
    data['success'] = this.success;
    return data;
  }
}