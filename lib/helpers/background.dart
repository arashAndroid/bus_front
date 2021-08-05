import 'package:flutter/material.dart';

import 'Constants.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              "images/top1.png",
              width: size.width,
              color: colorBackgroundCurves,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              "images/top2.png",
              width: size.width,
              color: colorBackgroundCurves,
            ),
          ),
          Positioned(
            top: 50,
            right: 30,
            child: Hero(
                tag: 'busIcon',
                child:
                    Image.asset("images/icon.png", width: size.width * 0.25)),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "images/bottom1.png",
              width: size.width,
              color: colorBackgroundCurves,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "images/bottom2.png",
              width: size.width,
              color: colorBackgroundCurves,
            ),
          ),
          child
        ],
      ),
    );
  }
}
