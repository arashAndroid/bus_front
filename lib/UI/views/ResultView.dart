import 'package:bus/UI/widgets/HalfCircle.dart';
import 'package:bus/UI/widgets/QuarterCircle.dart';
import 'package:bus/UI/widgets/TravelItem.dart';
import 'package:bus/core/viewmodels/ResultViewModel.dart';
import 'package:bus/helpers/AnimationHandler.dart';
import 'package:bus/helpers/Constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ResultView extends StatefulWidget {
  const ResultView({Key key}) : super(key: key);

  @override
  _ResultViewState createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  ResultViewModel resultViewModel;
  @override
  void initState() {
    super.initState();
    resultViewModel = Provider.of<ResultViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: colorBackground,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            key: const Key('mainAppBar'),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'نتایج جستجو',
              style: TextStyle(
                color: colorTextPrimary,
                fontSize: fontSizeTitle + 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            iconTheme: const IconThemeData(color: colorTextPrimary),
          ),
          body: Stack(
            children: [
              const Positioned(
                bottom: 0,
                right: 0,
                child: Hero(
                  tag: "bottomBig",
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: QuarterCircle(
                      circleAlignment: QuarterCircleAlignment.bottomRight,
                    ),
                  ),
                ),
              ),
              const Positioned(
                bottom: 0,
                right: 0,
                child: Hero(
                  tag: "bottomSmall",
                  child: SizedBox(
                    height: 75,
                    width: 75,
                    child: QuarterCircle(
                      circleAlignment: QuarterCircleAlignment.bottomRight,
                    ),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Hero(
                  tag: "topBig",
                  child: SizedBox(
                    height: 200,
                    width: 100,
                    child: HalfCircle(
                      circleAlignment: HalfCircleAlignment.left,
                    ),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Hero(
                  tag: "topSmall",
                  child: SizedBox(
                    height: 100,
                    width: 50,
                    child: HalfCircle(
                      circleAlignment: HalfCircleAlignment.left,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  constraints: kIsWeb
                      ? BoxConstraints(maxWidth: size.width / 3)
                      : const BoxConstraints(),
                  child: Consumer<ResultViewModel>(
                    builder: (_, resultConsumer, __) => ListView.builder(
                        itemCount: resultConsumer.travelDetails.length,
                        itemBuilder: (context, index) =>
                            AnimationHandler().translateFromRight(
                                TravelItem(
                                  travelDetail:
                                      resultConsumer.travelDetails[index],
                                ),
                                Curves.easeOutCubic,
                                index * 200.0)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
