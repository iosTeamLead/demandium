import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';

class OnHover extends StatefulWidget {
  final Widget Function(bool isHovered) builder;
  const OnHover({Key? key, required this.builder}) : super(key: key);

  @override
  OnHoverState createState() => OnHoverState();
}

class OnHoverState extends State<OnHover> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    final isLtr = Get.find<LocalizationController>().isLtr;
    final matrixLtr =  Matrix4.identity()..translate(2,0,0);
    final matrixRtl =  Matrix4.identity()..translate(-2,0,0);
    final transform = isHovered ? isLtr ? matrixLtr : matrixRtl : Matrix4.identity();
    return MouseRegion(
      onEnter: (_) {
        onEntered(true);
      },
      onExit: (_){
        onEntered(false);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: transform,             // animation transformation hovered.
        child: widget.builder(isHovered,),   // build the widget passed from main.dart
      ),
    );
  }
  void onEntered(bool isHovered){
    setState(() {
      this.isHovered = isHovered;
    });
  }
}