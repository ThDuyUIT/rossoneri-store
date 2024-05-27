import 'package:flutter/material.dart';
import 'package:rossoneri_store/src/constants/app_sizes.dart';

class InputWidget extends StatefulWidget {
  final String hintText;
  final String labelText;
  final TextEditingController? controller;
  //final FocusNode focusNode;
  final String? defaultValue;
  final VoidCallback? onChange;
  final bool? coverSuffixIcon;
  //final bool? editSuffixIcon;
  bool? readOnlyTextField;
  final String invalidator;
  final Color color;

  InputWidget(
      {super.key,
      required this.hintText,
      required this.labelText,
      required this.controller,
      //required this.focusNode,
      this.onChange,
      this.defaultValue,
      this.coverSuffixIcon = false,
      //this.editSuffixIcon = false,
      this.readOnlyTextField = false,
      this.invalidator = '',
      this.color = Colors.white});

  @override
  State<StatefulWidget> createState() {
    return StateInputWidget();
  }
}

class StateInputWidget extends State<InputWidget> {
  IconData editIcon = Icons.edit_rounded;
  bool isSave = false;
  bool isVisible = false;

  void updateVisibility() {
    setState(() {
      if (isVisible) {
        isVisible = false;
      } else {
        isVisible = true;
      }
    });
  }

  @override
  void initState() {
    if (widget.defaultValue != null) {
      widget.controller?.text = widget.defaultValue!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          readOnly: widget.readOnlyTextField ?? false,
          onChanged: (value) {
            widget.onChange == null ? null : widget.onChange!();
          },
          style: TextStyle(color: widget.color),
          //focusNode: widget.focusNode,
          controller: widget.controller,
          obscureText: widget.coverSuffixIcon == true ? !isVisible : isVisible,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(color: widget.color),
            suffix: widget.coverSuffixIcon == true
                ? GestureDetector(
                    onTap: () {
                      updateVisibility();
                    },
                    child: Icon(
                      isVisible
                          ? Icons.visibility_rounded
                          : Icons.visibility_off_rounded,
                      size: Sizes.p32,
                      color: widget.color,
                    ),
                  )
                : null,
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
