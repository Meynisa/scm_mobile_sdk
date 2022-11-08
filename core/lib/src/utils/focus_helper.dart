import 'package:flutter/material.dart';

dismissKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}
