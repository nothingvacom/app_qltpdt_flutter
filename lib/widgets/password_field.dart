import 'package:app_qltpdt_flutter/utils/vc_const.dart';
import 'package:flutter/material.dart';
class PasswordField extends StatefulWidget{
  const PasswordField({
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.controller
  });
  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;
  final TextEditingController controller;
  @override
  _PasswordFieldState createState()=>_PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField>{
  bool _obscureText=true;
  @override
  Widget build(BuildContext context) {
    return new TextFormField(
      key: widget.fieldKey,
      controller: widget.controller,
      obscureText: _obscureText,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: new InputDecoration(
        labelStyle: VcConst.getStyleCaption(context),
        fillColor: Colors.transparent,
        contentPadding: EdgeInsets.all(5.0),
        border: UnderlineInputBorder(),
        focusedBorder:UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).textSelectionHandleColor),
        ),
        filled: true,
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
        suffixIcon: new GestureDetector(
          onTap: (){
            setState(() {
              _obscureText=!_obscureText;
            });
          },
          child: new Icon(!_obscureText?Icons.visibility:Icons.visibility_off,
              color: !_obscureText?Theme.of(context).textSelectionHandleColor:Theme.of(context).disabledColor),
        )
      ),
    );
  }
}