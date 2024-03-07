import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContainerWidget extends StatefulWidget {
  final String text;
  final Color color;
  const ContainerWidget({
    Key? key,
    required this.text, required this.color,
  }) : super(key: key);

  @override
  State<ContainerWidget> createState() => _ContainerWidgetState();
}

class _ContainerWidgetState extends State<ContainerWidget> {
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      color: Colors.white,
      elevation: 0,
      child:
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [
          Text(
            widget.text,
            style: GoogleFonts.roboto(
              color: widget.color,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ]),
        Icon(
          Icons.arrow_forward_ios,
          color: widget.color,
          size: 18,
        ),
      ]),
    ),

  );
}