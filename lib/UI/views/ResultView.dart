import 'package:bus/core/viewmodels/ResultViewModel.dart';
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
    return Scaffold(
      body: Consumer<ResultViewModel>(
        builder: (_, resultConsumer, __) => Container(),
      ),
    );
  }
}
