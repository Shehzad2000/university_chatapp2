import 'package:flutter/material.dart';
IconButton iconButton(IconData? iconData,Color? colors,double? size, ){
  return IconButton(
      onPressed: (){},icon: Icon(iconData),color: colors,iconSize: size, );
}
class IconButtonWidget extends StatefulWidget {
  IconData? iconData;
  Color? color;
  double? size;
  VoidCallback? onPressed;
   IconButtonWidget({Key? key, this.iconData, this.color, this.size, this.onPressed}) : super(key: key);

  @override
  State<IconButtonWidget> createState() => _IconButtonWidgetState();
}

class _IconButtonWidgetState extends State<IconButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed:widget.onPressed ,icon: Icon(widget.iconData),color: widget.color,iconSize: widget.size, );
  }
  }

