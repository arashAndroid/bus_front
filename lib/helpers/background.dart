import 'package:flutter/material.dart';

import 'Constants.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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
          kIsWeb
              ? Container()
              : Positioned(
                  top: 0,
                  right: 0,
                  child: Image.asset(
                    "images/top1.png",
                    width: size.width,
                    color: colorBackgroundCurves,
                  ),
                ),
          kIsWeb
              ? Container()
              : Positioned(
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
                child: Image.asset("images/icon.png",
                    width: kIsWeb ? 100 : size.width * 0.25)),
          ),
          kIsWeb
              ? Container()
              : Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset(
                    "images/bottom1.png",
                    width: size.width,
                    color: colorBackgroundCurves,
                  ),
                ),
          kIsWeb
              ? Container()
              : Positioned(
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
