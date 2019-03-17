import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:facite_alumnos/models/ModelLogin.dart';
import 'package:facite_alumnos/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:facite_alumnos/utils/utils.dart';
import 'package:facite_alumnos/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginPage extends StatefulWidget {
  final Function changePage;

  LoginPage(this.changePage);

  @override
  State<StatefulWidget> createState() {
    return _LoginState(changePage);
  }
}

class _LoginState extends State<LoginPage> {
  final Function _changePage;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final Map<String, dynamic> _loginData = {
    'email' : null,
    'password' : Null
  };

  

  

   //Metodo para realizar el login
  _login() async {
   final response = await http.get("http://facite.uas.edu.mx/alumnos/api/api_login.php?cuenta=${_loginData['email']}&password=${_loginData['password']}");
  var datauser = json.decode(response.body);
  //print(datauser);
  List<FACITEAPP> e;
  e = (datauser['FACITE_APP'] as List)
      .map((p) => FACITEAPP.fromJson(p))
      .toList();
  String msg='';
  if(datauser.length==0){
    setState(() {
          msg="No se pudo conectar al servidor";
          _showDialog(msg, 'Error del servidor');
        });
  }else{
    if(e[0].success=='0'){
      //_showDialog(msg, 'Usuario o contrasena incorrectas');
      Alert(
                      context: context,
                      //type: AlertType.info,
                      title: "Fallo al iniciar sesion",
                      desc: "Usuario o Contrasena Incorrectas",
                      image: Image.asset("assets/img/error.gif", width: 50,),
                      buttons: [
                        DialogButton(
                          child: Text(
                            "Cerrar!",
                            style: TextStyle(color: Colors.white, fontSize: 20,),
                          ),
                           onPressed: () => Navigator.pop(context),
                          width: 140,
                        ),
                       
                      ],
                    ).show();
    }else if(e[0].success=='1'){
      
      //_showDialog("buala vas a iniciar sesion","${e[0].name}");
      Navigator.pushReplacementNamed(context, '/home');
    }
    
    setState(() {
          globals.cuenta = e[0].cuenta;
          globals.nombre = e[0].name;
        });
  }
}

_showDialog(String mensaje, String titulo) async {
    await showDialog<String>(
      context: context,
      child: new AlertDialog(
        contentPadding: const EdgeInsets.all(20.0),
        title: new Text(titulo),
        content: new Text(mensaje),
        actions: <Widget>[
          new FlatButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }




  _LoginState(this._changePage);

  @override
  Widget build(BuildContext context) {
    return _buildLoginWidget(_formKey, context: context);
  }

  Form _buildLoginWidget(GlobalKey formkey, {context: BuildContext}) {

    Widget _buildEmailField() {
      return TextFormField(
        // autovalidate: true,
        validator: (String value) {
          if (!isNoCuenta(value) || value.trim().isEmpty) return 'Por favor ingrese un Número de Cuenta válido.';
        },

        style: TextStyle(color: Colors.white),
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.emailAddress,
        decoration: textDecoration('No. Cuenta'),
        onSaved: (String value) {
              _loginData['email'] = value;
        },
      );
    }

    Widget _buildPasswordField() {
      return TextFormField(
        initialValue: '',  // used to set the initial value
        validator: (String value) {
          if (value.trim().isEmpty) return 'Por favor ingrese su Contraseña.';
        },
        style: TextStyle(color: Colors.white),
        keyboardType: TextInputType.emailAddress,
        decoration: textDecoration('Contraseña'),
        onSaved: (String value) {
              _loginData['password'] = value;
        },
      );
    }

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _buildEmailField(),
          SizedBox(
            height: 15,
          ),
          _buildPasswordField(),
          SizedBox(
            height: 15,
          ),

          GestureDetector(
            onTap: () {},
            child: Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(top: 25, right: 5),
              child: Text(
                '¿Olvidaste la Contraseña?',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),

          // SwitchListTile(
          //   title: Text('I accept the Terms & Conditions'),
          //   value: _acceptTerms,
          //   onChanged: (bool value) {
          //     setState(() {
          //       _acceptTerms = value;
          //     });
          //   },
          // ),
          SizedBox(
            height: 25,
          ),
          FlatButton(
            shape: new RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                side: BorderSide(color: Colors.white)),
            padding: EdgeInsets.only(
              left: 50,
              right: 50,
            ),
            // color: Theme.of(context).buttonColor,
            textColor: Colors.white,
            child: Text('Ingresar'),
            onPressed: () {
              /*Navigator.pushReplacement(   // replcet the curent layout unlike push that just creates new page
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext cotext) => MyApp()));
              */
              // Using Routes

              _formKey.currentState.save();

              if (!_formKey.currentState.validate()) {
                return;
              } else {
                //Navigator.pushReplacementNamed(context, '/home');
                _login();
              }
            },
          ),
          /*Container(
            margin: EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            child: Text(
              'Or',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          FlatButton(
            child: Text(
              'Create an account, Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            onPressed: () {
              _changePage(false);
            },
          ),*/
        ],
      ),
    );
  }
}