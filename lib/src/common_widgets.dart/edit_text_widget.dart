import 'package:flutter/material.dart';
import 'package:rossoneri_store/src/constants/app_sizes.dart';

class EditTextWidget extends StatefulWidget {
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final String? defaultValue;
  // final VoidCallback? onChange;
  bool? readOnlyTextField;
  final String invalidator;
  final Color color;

  final VoidCallback onTap;
  final IconData suffixIcon;

  EditTextWidget({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.controller,
    required this.onTap,
    required this.suffixIcon,
    //this.onChange,
    this.defaultValue,
    this.readOnlyTextField = false,
    this.invalidator = '',
    this.color = Colors.white,
  });

  @override
  State<StatefulWidget> createState() {
    return StateEditTextWidget();
  }
}

class StateEditTextWidget extends State<EditTextWidget> {
  @override
  void initState() {
    if (widget.defaultValue != null) {
      widget.controller.text = widget.defaultValue!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          readOnly: widget.suffixIcon == Icons.edit_rounded ? true : false,
          style: TextStyle(color: widget.color),
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(color: widget.color),
            suffix: IconButton(
              icon: Icon(widget.suffixIcon, color: widget.color, size: Sizes.p16,),
              onPressed: widget.onTap,
            ),
            label: Text(
              widget.labelText,
              style: TextStyle(color: widget.color),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            enabledBorder: OutlineInputBorder(
              // Change the default border color
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                  color: widget.color, width: 2), // Change color and width
            ),
          ),
        ),
        widget.invalidator.isEmpty
            ? const SizedBox()
            : Align(
                alignment: Alignment.centerRight,
                child: Text(widget.invalidator,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: widget.color, fontWeight: FontWeight.bold)))
      ],
    );
  }
}
