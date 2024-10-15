import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.mainText,
    this.initialValue,
    required this.onChange,
    required this.validator,
    this.textInputType,
    this.inputFormatter,
    this.onWidgetCreate,
    required this.obscureText,
    this.borderRadius,
    this.textAlign = TextAlign.center,
    this.controller,
    this.focusNode,
    this.preferSize,
    this.suffixIcon = const Icon(Icons.search_rounded),
    this.backgroundColor,
    this.cursorColor,
    this.prefixIcon,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines = 1,
    this.showHintBorder = false,
    this.showAllBorder = false,
    this.showFocusBorder = false,
    this.showAllBorderWhenHasText = false,
  });
  final String hintText;
  final String mainText;
  final String? initialValue;
  final Color? backgroundColor;
  final Color? cursorColor;
  final Function(String value) onChange;
  final Function(String? value) validator;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatter;
  final Function()? onWidgetCreate;
  final bool obscureText;
  final TextAlign? textAlign;
  final double? borderRadius;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Size? preferSize;
  final Widget suffixIcon;
  final Widget? prefixIcon;
  final bool readOnly;
  final bool showFocusBorder;
  final bool showAllBorder;
  final bool showAllBorderWhenHasText;
  final bool showHintBorder;
  final int maxLines;
  final int minLines;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late TextEditingController controller;
  late FocusNode focusNode;
  bool obscureText = false;
  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
    controller = widget.controller ?? TextEditingController();
    focusNode = widget.focusNode ?? FocusNode();
    if (widget.initialValue != null) {
      controller.text = widget.initialValue!;
      if (widget.onWidgetCreate != null) {
        widget.onWidgetCreate!();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);

    return Container(
      clipBehavior: Clip.none,
      height: widget.preferSize?.height,
      width: widget.preferSize?.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
          border: (((controller.text.isNotEmpty &&
                      widget.showAllBorderWhenHasText) ||
                  widget.showAllBorder))
              ? Border.all(width: 1, color: Colors.blue)
              : null),
      child: TextFormField(
        readOnly: widget.readOnly,
        focusNode: focusNode,
        controller: controller,
        keyboardType: widget.textInputType ?? TextInputType.text,
        inputFormatters: widget.inputFormatter,
        obscureText: obscureText,
        scrollPadding: EdgeInsets.only(bottom: height / 2, top: 100),
        validator: (value) => widget.validator(value),
        style: Theme.of(context).textTheme.bodyLarge!,
        onChanged: (value) {
          setState(() {});
          widget.onChange(value);
        },
        decoration: InputDecoration(
          suffixIcon: widget.obscureText
              ? IconButton(
                  onPressed: () {
                    obscureText = !obscureText;
                    setState(() {});
                  },
                  icon: controller.text.isNotEmpty
                      ? obscureText
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off_rounded)
                      : widget.suffixIcon)
              : widget.suffixIcon is Container
                  ? null
                  : widget.suffixIcon,
          prefixIcon: widget.prefixIcon,
          // prefixIconConstraints: BoxConstraints.tight(const Size(40, 40)),
          suffixIconColor: Colors.white,
          hintText: widget.hintText,

          hintStyle: TextStyle(
              letterSpacing: 2, color: theme.textTheme.bodySmall!.color),
          filled: true,
          fillColor: widget.backgroundColor ?? Colors.white,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
              borderSide: widget.showHintBorder
                  ? const BorderSide(width: 1, color: Colors.blue)
                  : const BorderSide(width: 0, color: Colors.blue)),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
            // borderSide:
            //     controller.text.isNotEmpty && widget.alwaysDoNotShowBorder
            //         ? const BorderSide(color: Colors.transparent)
            //         : const BorderSide(width: 2, color: Colors.red),
          ),
          errorStyle: const TextStyle(fontSize: 10),
          errorMaxLines: 2,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
            borderSide: widget.showFocusBorder
                ? const BorderSide(color: Colors.transparent)
                : const BorderSide(width: 1, color: Colors.blue),
          ),
          label: widget.mainText.isNotEmpty
              ? Text(widget.mainText,
                  style: const TextStyle(color: Colors.white))
              : null,
        ),
        // maxLines: widget.maxLines,
        // minLines: widget.minLines,
        expands: widget.preferSize != null,
        maxLines: null,
        minLines: null,
        textAlign: widget.textAlign!,
        cursorColor: widget.cursorColor ?? Colors.white,
      ),
    );
  }
}
