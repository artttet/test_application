import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  AppTextField({
    required Key key,
    this.maxLines,
    required this.hintText,
    required this.labelText,
    this.errorText,
    this.onChanged,
    this.onSubmitted,
    this.validate
  }) : super(key: key);

  final int? maxLines;
  final String hintText;
  final String labelText;
  final String? errorText;
  final ValueChanged<String?>? onChanged;
  final ValueChanged<String?>? onSubmitted;
  final RegExp? validate;

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late TextEditingController controller;
  late FocusNode focusNode;
  String? errorText;

  @override
  void initState() { 
    controller = TextEditingController();
    focusNode = FocusNode()
    ..addListener(() { 
      if (widget.validate != null) {
        if (focusNode.hasFocus && errorText != null) {
          setState(() => errorText = null);
        }

        if (!focusNode.hasFocus) {
          if (controller.text != '') {
            if (!widget.validate!.hasMatch(controller.text)) {
              setState(() => errorText = widget.errorText);
            }
          }
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return TextField(
      controller: controller,
      focusNode: focusNode,
      autocorrect: false,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: widget.hintText,
        labelText: widget.labelText,
        errorText: errorText
      ),
      cursorColor: Colors.purple,
      textInputAction: TextInputAction.done,
      onChanged: (text) {
        if (widget.onChanged != null) {
          final validate = widget.validate;
          if (validate != null) {
            if (!validate.hasMatch(text)) {
              widget.onChanged!.call(null);
              setState(() {
                errorText = widget.errorText ?? null;
              });
            } else {
              widget.onChanged!.call(text);
            }
          } else {
            widget.onChanged!.call(text);
          }
        }

      },
      onSubmitted: (text) {
        if (widget.onSubmitted != null) {
          final validate = widget.validate;
          if (validate != null) {
            if (!validate.hasMatch(text)) {
              widget.onSubmitted!.call(null);
              setState(() {
                errorText = widget.errorText ?? null;
              });
            } else {
              widget.onSubmitted!.call(text);
            }
          } else {
            widget.onSubmitted!.call(text);
          }
        }
        focusNode.unfocus();
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }
}