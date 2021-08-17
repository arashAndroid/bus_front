import 'package:bus/UI/widgets/TravelItem.dart';
import 'package:bus/core/viewmodels/ResultViewModel.dart';
import 'package:bus/helpers/AnimationHandler.dart';
import 'package:bus/helpers/Constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: colorBackground,
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
        body: Consumer<ResultViewModel>(
          builder: (_, resultConsumer, __) => ListView.builder(
              itemCount: resultConsumer.travelDetails.length,
              itemBuilder: (context, index) =>
                  AnimationHandler().translateFromRight(
                      TravelItem(
                        travelDetail: resultConsumer.travelDetails[index],
                      ),
                      Curves.easeOutCubic,
                      index * 200.0)),
        ),
      ),
    );
  }
}
