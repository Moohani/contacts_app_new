import 'package:contacts_app_new/presentation/styles/colors.dart';
import 'package:country_code_picker/country_code.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

class DefaultPhoneFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final Color? labelColor;
  final Color? textColor;
  final InputBorder? border;
  final String? hintText;
  final String? Function(String?)? valdiator;
  final void Function(CountryCode)? onChange;

  const DefaultPhoneFormField({
    Key? key,
    required this.controller,
    this.labelText,
    this.labelColor,
    this.textColor,
    this.border = const OutlineInputBorder(borderSide: BorderSide(width: 1)),
    this.hintText = 'Eg.123456789',
    this.valdiator,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: valdiator,
      controller: controller,
      keyboardType: TextInputType.phone,
      style: TextStyle(
        color: textColor,
      ),
      decoration: InputDecoration(
       prefixIcon: CountryCodePicker(
         onChanged: onChange,
         initialSelection: 'EG',
         favorite: const [
           '+20',
           'EG'
         ],
       ),
        isDense: true,
        border: border,
        hintText: hintText,
        iconColor: white,
        hintStyle: const TextStyle(color: Colors.grey),
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.caption!.copyWith(
          color: labelColor,
        ),
        hintTextDirection: TextDirection.ltr,
      ),
    );
  }
}
