import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class TextFieldWidget extends StatefulWidget {
  final Color cursorColor;
  final TextEditingController controller;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool obscureText;
  final String text;
  final String hintText;
  final int Maxline;
  const TextFieldWidget({
    Key? key,
    required this.controller,
    required this.obscureText,
    required this.inputType,
    required this.text,
    required this.hintText,
    required this.cursorColor,
    required this.inputAction,
    required this.Maxline,
  }) : super(key: key);



  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget  build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (widget.text.isNotEmpty)?Text(widget.text,
            style: GoogleFonts.roboto(
              color: const Color(0xff000000),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            )):Container(),
        const SizedBox(
          height: 10,
        ),
        Container(

          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          child: TextField(
            cursorColor: widget.cursorColor,
            obscureText: widget.obscureText,
            controller: widget.controller,
            keyboardType: widget.inputType,
            textInputAction: widget.inputAction,
            maxLines: widget.Maxline,
            decoration: InputDecoration(
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              border: InputBorder.none,

              //  prefixIcon: Icon(Icons.phone),
              hintText: widget.hintText,
              hintStyle: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffB7B8B8)),
            ),
            style: GoogleFonts.roboto(
              color: Color(0xff858585),
              fontWeight: FontWeight.w400,
              fontSize: 17,
            ),
          ),
        ),

      ],
    );
  }
}