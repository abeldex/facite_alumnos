import 'package:facite_alumnos/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:facite_alumnos/utils/utils.dart';

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
  final Map<String, dynamic> _loginData = {
    'email' : null,
    'password' : Null
  };

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
              Navigator.pushReplacement(   // replcet the curent layout unlike push that just creates new page
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext cotext) => MyApp()));

              // Using Routes

              _formKey.currentState.save();

              if (!_formKey.currentState.validate()) {
                return;
              } else {
                Navigator.pushReplacementNamed(context, '/home');
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