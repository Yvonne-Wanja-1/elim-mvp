import 'package:flutter/material.dart';

class Mytextfield extends StatefulWidget {
  final TextEditingController? controller;

   const Mytextfield({super.key,
   this.controller,
   this.labelText, 
   this.helperText, 
   this.hintText,
   this.errorText,
   this.obscureText,
   this.keyboardType,
   this.textInputAction,
   this.prefixIcon,
   });
  final String? labelText;
  final String? helperText;
  final String? hintText;
  final String? errorText;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final IconData? prefixIcon;

  @override
  State<Mytextfield> createState() => _MytextfieldState();
}

class _MytextfieldState extends State<Mytextfield> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0), // Match TextField's border radius
     
  ),
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Keep padding for inner TextField
        child: TextField(
          controller: widget.controller,
          focusNode: _focusNode,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0), 
              borderSide: const BorderSide(color: Colors.grey, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0), 
              borderSide: const BorderSide(color: Colors.blue, width: 2.0),
            ),
            
            labelText: widget.labelText,
            labelStyle: TextStyle(color: _isFocused ? Colors.blue : Colors.black),
            helperText: widget.helperText,
            fillColor: _isFocused ? Colors.white : const Color.fromARGB(255, 139, 187, 227),
            filled: true,
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            errorText: widget.errorText,
            errorStyle: const TextStyle(color: Colors.red),
            prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon, color: Colors.black) : null,
          ),
          style: const TextStyle(color: Colors.black),    
          cursorColor: Colors.blue,
          cursorHeight: 20,
          cursorWidth: 2,
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          maxLines: 1,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          obscureText: widget.obscureText ?? false,
          obscuringCharacter: '*',
          autocorrect: true,
          enableSuggestions: true,  
        ),
      ),
    );
  }
}