import 'dart:ui';

import 'package:bus/UI/widgets/DrawerItem.dart';
import 'package:bus/UI/widgets/ExitDialog.dart';
import 'package:bus/UI/widgets/NoInternetWidget.dart';
import 'package:bus/core/viewmodels/MainViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../../helpers/Constants.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class MainView extends StatefulWidget {
  const MainView({Key key}) : super(key: key);
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  MainViewModel mainViewModel;
  GlobalKey<AutoCompleteTextFieldState<String>> keySource;
  GlobalKey<AutoCompleteTextFieldState<String>> keyDestination;

  @override
  void initState() {
    mainViewModel = Provider.of<MainViewModel>(context, listen: false);
    mainViewModel.init(context);

    keySource = GlobalKey();
    keyDestination = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double myWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            key: const Key('mainAppBar'),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'اتوبوس',
              style: TextStyle(
                color: colorTextPrimary,
                fontSize: fontSizeTitle + 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            iconTheme: const IconThemeData(color: colorTextPrimary),
          ),
          drawer: Drawer(
            key: const Key('drawerButton'),
            child: ListView(
              // Important: Remove any padding from the ListView.
              key: const Key('drawer'),
              padding: EdgeInsets.zero,
              children: <Widget>[
                Consumer<MainViewModel>(
                  builder: (_, user, __) => Container(
                    alignment: Alignment.bottomRight,
                    height: 125,
                    child: Container(
                      alignment: Alignment.bottomRight,
                      padding: const EdgeInsets.all(0),
                      child: ClipRRect(
                        // make sure we apply clip it properly
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 8, right: 8),
                            alignment: Alignment.bottomRight,
                            color: Colors.green.withOpacity(0.1),
                            child: Text(
                              user.user.username == null
                                  ? 'بدون نام'
                                  : user.user.username == 'null'
                                      ? 'بدون نام'
                                      : user.user.username,
                              style: const TextStyle(
                                  color: colorTextPrimary,
                                  fontSize: fontSizeTitle + 10,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage("images/bus.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () async {
                    Navigator.pushNamed(
                      context,
                      '/WalletView',
                    );
                  },
                  child: drawerItem(
                    title: 'کیف پول',
                    icon: Icons.wallet_travel_rounded,
                  ),
                ),
                Consumer<MainViewModel>(
                  builder: (_, main, __) => InkWell(
                    onTap: () async {
                      Navigator.pushNamed(
                        _,
                        '/ProfileView',
                      );
                    },
                    child: drawerItem(
                      title: 'تنظیمات پروفایل',
                      icon: Icons.apps,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/AboutUsView');
                  },
                  child: drawerItem(
                    title: 'درباره‌ی ما',
                    icon: Icons.error_outline,
                  ),
                ),
                InkWell(
                  child: drawerItem(
                    title: 'خروج',
                    icon: Icons.exit_to_app,
                  ),
                  onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) => ExitDialog()),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height -
                  (AppBar().preferredSize.height),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child:
                    Consumer<MainViewModel>(builder: (_, mainContainerVM, __) {
                  return mainContainerVM.noInternet
                      ? NoInternetWidget(
                          function: mainViewModel.init, context: context)
                      : Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(
                              left: 0.0, right: 0.0, top: 5.0),
                          child: SingleChildScrollView(
                            key: const Key('mainViewKey'),
                            child: Consumer<MainViewModel>(
                              builder: (_, wholeMinVConsumer, __) => Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    height: 120,
                                    margin: const EdgeInsets.only(bottom: 32),
                                    child: const Image(
                                        image: AssetImage('images/icon.png')),
                                  ),
                                  Container(
                                    width: myWidth,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 5,
                                              spreadRadius: 1)
                                        ]),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    child: Stack(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 12,
                                                  top: 8,
                                                  bottom: 8,
                                                  right: 12),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: colorPrimary,
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  boxShadow: const [
                                                    BoxShadow(
                                                        color: Colors.black12,
                                                        blurRadius: 5,
                                                        spreadRadius: 1)
                                                  ]),
                                              child: const Icon(
                                                Icons.search,
                                                color: Colors.white,
                                                size: 35,
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    left: 8,
                                                    right: 16,
                                                    top: 16,
                                                    bottom: 16),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 32,
                                                              bottom: 12),
                                                      child: const Text(
                                                        'جستجوی اتوبوس',
                                                        style: TextStyle(
                                                            color:
                                                                colorTextPrimary,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                fontSizeTitle),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Container(
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        0,
                                                                    vertical:
                                                                        6),
                                                            margin:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        0),
                                                            child: Consumer<
                                                                MainViewModel>(
                                                              builder: (_,
                                                                      sourceViewModel,
                                                                      __) =>
                                                                  Directionality(
                                                                textDirection:
                                                                    TextDirection
                                                                        .rtl,
                                                                key: const Key(
                                                                    'sourceInput'),
                                                                child: sourceViewModel
                                                                            .loading ==
                                                                        true
                                                                    ? const Center(
                                                                        child:
                                                                            SpinKitThreeBounce(
                                                                          size:
                                                                              25,
                                                                          color:
                                                                              colorTextSub,
                                                                        ),
                                                                      )
                                                                    : Directionality(
                                                                        textDirection:
                                                                            TextDirection.rtl,
                                                                        child:
                                                                            Stack(
                                                                          children: [
                                                                            SimpleAutoCompleteTextField(
                                                                              key: keySource,
                                                                              suggestions: sourceViewModel.capitalSourceTownsList,
                                                                              // style: TextStyle(color: colorTextSub),
                                                                              focusNode: sourceViewModel.focusNodeSource,
                                                                              decoration: InputDecoration(
                                                                                focusColor: Colors.white,
                                                                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                                                                labelText: 'مبدا',
                                                                                border: OutlineInputBorder(
                                                                                  borderSide: BorderSide.none,
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                ),
                                                                                icon: Container(
                                                                                  padding: const EdgeInsets.all(8),
                                                                                  decoration: BoxDecoration(color: colorPrimary.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                                                                                  child: const Icon(
                                                                                    Icons.location_on,
                                                                                    color: colorPrimary,
                                                                                  ),
                                                                                ),
                                                                                labelStyle: TextStyle(color: colorTextSub, fontSize: sourceViewModel.focusNodeSource.hasFocus ? 21 : 17, height: 1.5),
                                                                              ),

                                                                              clearOnSubmit: false,
                                                                              controller: sourceViewModel.sourceController,
                                                                              textChanged: (String text) {
                                                                                sourceViewModel.onSourceTextChanged(text);
                                                                              },
                                                                              textSubmitted: (text) {
                                                                                if (text != "") {
                                                                                  sourceViewModel.setCurrentCapitalSource(text);
                                                                                }
                                                                              },
                                                                            ),
                                                                            Align(
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Container(
                                                                                margin: const EdgeInsets.only(left: 8),
                                                                                child: Icon(
                                                                                  Icons.check,
                                                                                  color: sourceViewModel.currentSource == null ? colorDeactivated : colorPrimary,
                                                                                  size: 20,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 0,
                                                          vertical: 6),
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 0),
                                                      child: Consumer<
                                                          MainViewModel>(
                                                        builder: (_,
                                                                destViewModel,
                                                                __) =>
                                                            Directionality(
                                                          textDirection:
                                                              TextDirection.rtl,
                                                          key: const Key(
                                                              'destinationInput'),
                                                          child: destViewModel
                                                                      .loading ==
                                                                  true
                                                              ? const Center(
                                                                  child:
                                                                      SpinKitThreeBounce(
                                                                    size: 25,
                                                                    color:
                                                                        colorPrimary,
                                                                  ),
                                                                )
                                                              : Stack(
                                                                  children: [
                                                                    SimpleAutoCompleteTextField(
                                                                      key:
                                                                          keyDestination,
                                                                      suggestions:
                                                                          destViewModel
                                                                              .capitalSourceTownsList,
                                                                      // style: TextStyle(color: colorTextSub),
                                                                      decoration:
                                                                          InputDecoration(
                                                                        fillColor:
                                                                            colorPrimaryGrey,
                                                                        focusColor:
                                                                            Colors.white,
                                                                        contentPadding: const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                16,
                                                                            vertical:
                                                                                4),
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide.none,
                                                                          borderRadius:
                                                                              BorderRadius.circular(40),
                                                                        ),
                                                                        filled:
                                                                            false,
                                                                        labelText:
                                                                            'مقصد',
                                                                        icon:
                                                                            Container(
                                                                          padding:
                                                                              const EdgeInsets.all(8),
                                                                          decoration: BoxDecoration(
                                                                              color: colorPrimary.withOpacity(0.2),
                                                                              borderRadius: BorderRadius.circular(10)),
                                                                          child:
                                                                              const Icon(
                                                                            Icons.flag,
                                                                            color:
                                                                                colorPrimary,
                                                                          ),
                                                                        ),
                                                                        labelStyle: TextStyle(
                                                                            color:
                                                                                colorTextSub,
                                                                            fontSize: destViewModel.focusNodeDestination.hasFocus
                                                                                ? 21
                                                                                : 17,
                                                                            height:
                                                                                1.5),
                                                                      ),
                                                                      clearOnSubmit:
                                                                          false,
                                                                      controller:
                                                                          destViewModel
                                                                              .destinationController,
                                                                      textChanged:
                                                                          (String
                                                                              text) {
                                                                        destViewModel
                                                                            .onDestTextChanged(text);
                                                                      },
                                                                      textSubmitted:
                                                                          (text) {
                                                                        if (text !=
                                                                            "") {
                                                                          destViewModel
                                                                              .setCurrentCapitalDestination(text);
                                                                        }
                                                                      },
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child:
                                                                          Container(
                                                                        margin: const EdgeInsets.only(
                                                                            left:
                                                                                8),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .check,
                                                                          color: destViewModel.currentDestination == null
                                                                              ? colorDeactivated
                                                                              : colorPrimary,
                                                                          size:
                                                                              20,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: myWidth,
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: <Widget>[
                                                          Container(
                                                            // opacity: wholeMinVConsumer.isRoundTrip ? 1.0 : 0.0,
                                                            key: const Key(
                                                                'dateInput'),
                                                            alignment: Alignment
                                                                .center,

                                                            child: Consumer<
                                                                MainViewModel>(
                                                              builder: (_,
                                                                      rowDateMainVM,
                                                                      __) =>
                                                                  GestureDetector(
                                                                child:
                                                                    AbsorbPointer(
                                                                  child:
                                                                      Container(
                                                                    margin: const EdgeInsets
                                                                            .only(
                                                                        left: 0,
                                                                        right:
                                                                            0),
                                                                    child:
                                                                        Directionality(
                                                                      textDirection:
                                                                          TextDirection
                                                                              .rtl,
                                                                      child:
                                                                          Stack(
                                                                        children: [
                                                                          TextField(
                                                                            controller:
                                                                                rowDateMainVM.currentDateController,
                                                                            focusNode:
                                                                                rowDateMainVM.focusNodeDate,
                                                                            style:
                                                                                const TextStyle(
                                                                              color: colorTextPrimary,
                                                                              fontSize: fontSizeTitle,
                                                                            ),
                                                                            decoration:
                                                                                InputDecoration(
                                                                              fillColor: colorPrimaryGrey,
                                                                              focusColor: Colors.white,
                                                                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                                                              border: OutlineInputBorder(
                                                                                borderSide: BorderSide.none,
                                                                                borderRadius: BorderRadius.circular(40),
                                                                              ),
                                                                              filled: false,
                                                                              labelText: 'تاریخ رفت',
                                                                              icon: Container(
                                                                                padding: const EdgeInsets.all(8),
                                                                                decoration: BoxDecoration(color: colorPrimary.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                                                                                child: const Icon(
                                                                                  Icons.flag,
                                                                                  color: colorPrimary,
                                                                                ),
                                                                              ),
                                                                              labelStyle: TextStyle(color: colorTextSub, fontSize: rowDateMainVM.focusNodeDate.hasFocus ? 21 : 17, height: 1.5),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.centerLeft,
                                                                            child:
                                                                                Container(
                                                                              margin: const EdgeInsets.only(left: 8),
                                                                              child: Icon(
                                                                                Icons.check,
                                                                                color: (rowDateMainVM.currentDateController.text == null || rowDateMainVM.currentDateController.text == '') ? colorDeactivated : colorPrimary,
                                                                                size: 20,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                key: const Key(
                                                                    'datePicker'),
                                                                onTap: () {
                                                                  FocusScope.of(
                                                                          context)
                                                                      .requestFocus(
                                                                          FocusNode()); // to prevent opening default keyboard
                                                                  showModalBottomSheet(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return rowDateMainVM
                                                                            .persianDatePicker;
                                                                      });
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          bottom: 0,
                                          child: Consumer<MainViewModel>(
                                            builder: (_, mainVM, __) => InkWell(
                                              key: const Key('searchButton'),
                                              onTap: () async {},
                                              child: Container(
                                                width: (12 + 35 + 12) * 1.0,
                                                padding: const EdgeInsets.only(
                                                    left: 12,
                                                    top: 8,
                                                    bottom: 8,
                                                    right: 12),
                                                alignment: Alignment.center,
                                                decoration: const BoxDecoration(
                                                    color: colorPrimary,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(25),
                                                      bottomLeft:
                                                          Radius.circular(25),
                                                      bottomRight:
                                                          Radius.circular(0),
                                                      topRight:
                                                          Radius.circular(0),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.black12,
                                                          blurRadius: 5,
                                                          spreadRadius: 1)
                                                    ]),
                                                child: mainVM.isSearching
                                                    ? const SpinKitThreeBounce(
                                                        size: 20,
                                                        color: Colors.white,
                                                      )
                                                    : const Icon(
                                                        Icons.search,
                                                        color: Colors.white,
                                                        size: 35,
                                                      ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
