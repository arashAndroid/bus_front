import 'dart:convert';

import 'package:bus/core/models/Travel.dart';
import 'package:bus/core/models/User.dart';
import 'package:bus/core/services/WebService.dart';
import 'package:bus/core/viewmodels/ResultViewModel.dart';
import 'package:bus/helpers/Constants.dart';
import 'package:bus/helpers/SharedPrefHelper.dart';
import 'package:bus/helpers/helperFunctions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:persian_date/persian_date.dart';
import 'package:persian_datepicker/persian_datepicker.dart';
import 'package:jalali_calendar/jalali_calendar.dart';

import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;

class MainViewModel with ChangeNotifier {
  final AuthServiceType authServiceType;

  MainViewModel({this.authServiceType});

  bool _noFestival = false;

  bool _isSearching = false;
  bool get isSearching => _isSearching;

  PersianDatePickerWidget persianDatePicker;
  PersianDatePickerWidget persianDatePickerRound;

  bool _loading = false;
  var selectedRange = RangeValues(0.0, 24.0);
  var capitalCitiesJson;
  TextEditingController _currentDateController = TextEditingController();
  final TextEditingController _roundTripDateController =
      TextEditingController();

  final FocusNode _focusNodeSource = FocusNode();
  final FocusNode _focusNodeDestination = FocusNode();
  final FocusNode _focusNodeDate = FocusNode();

  FocusNode get focusNodeSource => _focusNodeSource;
  FocusNode get focusNodeDestination => _focusNodeDestination;
  FocusNode get focusNodeDate => _focusNodeDate;

  final TextEditingController _sourceController =
      TextEditingController(text: "");
  final TextEditingController _destinationController =
      TextEditingController(text: "");
  int _currentQuantity = 1;
  int _childCurrentQuantity = 0;
  int currentYear = 1399;
  int currentMonth = 1;
  int currentDay = 1;
  int currentGregorianYear = 2020;
  int currentGregorianMonth = 1;
  int currentGregorianDay = 1;

  int roundTripYear = 1399;
  int roundTripMonth = 1;
  int roundTripDay = 1;

  String currentSource;
  String currentDestination;
  int currentSourceId = 0;
  int currentDestinationId = 0;
  String _currentDate;
  String _roundTripDate;
  bool _isRoundTrip = false;
  bool _noInternet = false;
  bool get noInternet => _noInternet;
  bool _isFirst = true;
  bool get isFirst => _isFirst;

  TextEditingController get sourceController => _sourceController;
  TextEditingController get destinationController => _destinationController;

  TextEditingController get currentDateController => _currentDateController;
  TextEditingController get roundTripDateController => _roundTripDateController;

  bool get isRoundTrip => _isRoundTrip;
  bool get noFestival => _noFestival;

  String get roundTripDate => _roundTripDate;

  // FestivalSearch get festivalSearch => _festivalSearch;

  bool get loading => _loading;

  User _user;
  User get user => _user;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  String dateString;
  String dateStringRound;

  BuildContext mainContext;

  List<int> quantity = [];
  List<String> sourceList = [];
  List<String> destinationList = [];

  List<String> _capitalSourceTownsList = [];
  List<String> _capitalDestinationTownsList = [];
  List<int> _capitalSourceTownsListID = [];
  List<int> _capitalDestinationTownsListID = [];

  List<String> get getSourceList {
    return sourceList;
  }

  List<String> get getDestinationList {
    return destinationList;
  }

  int getCityIdByName(String name) {
    for (int i = 0; i < sourceList.length; i++) {
      if (sourceList[i] == name) return i;
    }
    return 0;
  }

  void setCurrentSourceId(int id) {
    currentSourceId = id;
    notifyListeners();
  }

  void setCurrentDestinationId(int id) {
    currentDestinationId = id;
    notifyListeners();
  }

  RangeValues get getRangeValues {
    return selectedRange;
  }

  void setRangeValues(RangeValues rangeValues) {
    selectedRange = rangeValues;
    notifyListeners();
  }

  int get getCurrentQuantity {
    return _currentQuantity;
  }

  void minusOrPlusQnty(bool plus) {
    plus == true ? _currentQuantity++ : _currentQuantity--;
    if (_currentQuantity.isNegative) _currentQuantity = 0;
    notifyListeners();
  }

  void minusOrPlusChildQnty(bool plus) {
    plus == true ? _childCurrentQuantity++ : _childCurrentQuantity--;
    if (_childCurrentQuantity.isNegative) _childCurrentQuantity = 0;
    notifyListeners();
  }

  void setCurrentQuantity(int q) {
    _currentQuantity = q;
    print('currentQuantity = $_currentQuantity');
    notifyListeners();
  }

  int get getCurrentDay {
    return currentDay;
  }

  void setCurrentDay(int day) {
    currentDay = day;
    notifyListeners();
  }

  int get getCurrentMonth {
    // notifyListeners();
    return currentMonth;
  }

  void setCurrentMonth(int month) {
    currentMonth = month;
    notifyListeners();
  }

  int get getCurrentYear {
    return currentYear ?? 1399;
  }

  void setCurrentYear(int year) {
    currentYear = year;
    notifyListeners();
  }

  void setCurrentSource(String ss) {
    setCurrentSourceId(getCityIdByName(ss));
    currentSource = ss;
    notifyListeners();
  }

  void setCurrentDestination(String ss) {
    setCurrentDestinationId(getCityIdByName(ss));
    currentDestination = ss;
    notifyListeners();
  }

  String get getCurrentSource {
    return currentSource;
  }

  String get getCurrentDestination {
    return currentDestination;
  }

  init(BuildContext context) {
    _noInternet = false;
    if (!_isFirst) {
      notifyListeners();
    }
    mainContext = context;

    getUser().then((user) {
      _user = user;
      notifyListeners();
    });

    persianDatePicker = PersianDatePicker(
            onChange: (String oldText, String newText) {
              print(oldText);
              print(newText);
              Navigator.pop(context);
            },

            // rangeDatePicker: mainViewModel.isRoundTrip,
            rangeDatePicker: false,
            farsiDigits: true,
            fontFamily: "Sans",
            controller: _currentDateController,
            datetime: _currentDate,
            minDatetime: convertTojalali(DateTime.now().toString()),
            maxDatetime: null)
        .init();
    persianDatePickerRound = PersianDatePicker(
      onChange: (String oldText, String newText) {
        print(oldText);
        print(newText);
        Navigator.pop(context);
      },
      // rangeDatePicker: mainViewModel.isRoundTrip,
      rangeDatePicker: false,
      farsiDigits: true,
      fontFamily: "Sans",
      controller: _roundTripDateController,
      datetime: _currentDate,
      minDatetime: convertTojalali(DateTime.now().toString()),
    ).init();
    // _currentDateController.text = 'انتخاب تاریخ';
    _loading = true;
    // setTodayDate();

    getDestinationTownShip().then((result) {
      if (result) {
        _loading = false;
      } else {
        _loading = true;
        _noInternet = true;
      }
      notifyListeners();
    });
  }

  void setGregorianDate() {
    print("_currentDateController test = ${_currentDateController.text}");
    List<String> dateComponents = _currentDateController.text.split('/');

    currentYear = int.parse(convertNumbers(dateComponents[0]));

    currentMonth = int.parse(convertNumbers(dateComponents[1]));

    currentDay = int.parse(convertNumbers(dateComponents[2]));

    PersianDate persianDate = PersianDate();
    String month = "$currentMonth", day = "$currentDay";
    if (currentMonth.toString().length < 2) {
      month = "0$currentMonth";
    }
    if (currentDay.toString().length < 2) {
      day = "0$currentDay";
    }
    dateString = "$currentYear-$month-$day 19:54";
    dateString = persianDate.jalaliToGregorian(
        currentYear, int.parse(month), int.parse(day), '-');
    DateTime date = DateFormat('yyyy-M-D').parse(dateString);

    print('dateString = $dateString');
    print('date  = $date');

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    dateString = formatter.format(date);
    print('dateString geregorian converted  = ${this.dateString}');
  }

  void setGregorianDateRound() {
    print("setGregorianDateRound");
    print("_roundTripDateController test = ${_roundTripDateController.text}");
    // var eng= convertNumbers(_roundTripDateController.text);
    // var converted =
    //     PersianDateTime(jalaaliDateTime: eng);
    // var convertedRoundtrip = converted.toGregorian();
    // print("mahmooood convertig = $convertedRoundtrip");

    try {
      // String s = _currentDateController.text.substring(0, 4);
      // print("s = $s");

      roundTripYear = int.parse(
          convertNumbers(_roundTripDateController.text.substring(0, 4)));
    } on Exception catch (e) {
      roundTripYear = int.parse(_roundTripDate.substring(0, 4));
    }
    try {
      roundTripMonth = int.parse(
          convertNumbers(_roundTripDateController.text.substring(5, 7)));
    } on Exception catch (e) {
      roundTripMonth = int.parse(_roundTripDate.substring(5, 7));
    }
    try {
      roundTripDay = int.parse(
          convertNumbers(_roundTripDateController.text.substring(8, 10)));
      print("roundTripday = $roundTripDay");
    } on Exception catch (e) {
      roundTripDay = int.parse(_roundTripDate.substring(8, 10));
    }
    PersianDate persianDateRound = PersianDate();
    String month = "$roundTripMonth", day = "$roundTripDay";
    if (roundTripMonth.toString().length < 2) {
      month = "0$roundTripMonth";
    }
    if (roundTripDay.toString().length < 2) {
      day = "0$roundTripDay";
    }
    this.dateStringRound = "$roundTripYear-$month-$day 19:54";
    print('dateStringRound = $dateStringRound');
    // this.dateStringRound =
    //     persianDateRound.jalaliToGregorian(dateStringRound).toString();
    this.dateStringRound = persianDateRound
        .jalaliToGregorian(roundTripYear, int.parse(month), int.parse(day))
        .toString();

    this.dateStringRound = this.dateStringRound.substring(0, 10);
    if (authServiceType == AuthServiceType.mock) {
      this.dateStringRound = "2020-07-19"; //1399/04/29
    }
  }

  Future<bool> getResults(BuildContext context) async {
    if (_sourceController.text.isNotEmpty && currentSource.isNotEmpty) {
      if (getCapitalCityIdByName(_sourceController.text) != -1) {
        setCurrentSourceId(getCapitalCityIdByName(sourceController.text));
        currentSource = sourceController.text;
      }
      if (getCapitalCityIdByName(_destinationController.text) != -1) {
        setCurrentDestinationId(
            getCapitalCityIdByName(_destinationController.text));
        currentDestination = _destinationController.text;
      }
    }
    if (_destinationController.text.isNotEmpty &&
        currentDestination.isNotEmpty) {
      if (getCapitalCityIdByName(_destinationController.text) != -1) {
        setCurrentDestinationId(
            getCapitalCityIdByName(_destinationController.text));
        currentDestination = _destinationController.text;
      }
    }
    if (currentSource == null || currentDestination == null) {
      EasyLoading.showInfo('لطفا مبدا و مقصد را وارد کنید');
      return false;
    }
    if (_currentDateController.text == null ||
        _currentDateController.text == '') {
      EasyLoading.showInfo('لطفا تاریخ را وارد کنید');
      return false;
    }

    setGregorianDate();
    getCapitalCityID(currentSource, true); //128; //
    getCapitalCityID(currentDestination, false); //1018; //

    print(
        "sourceAndDestinationIds $currentSource $currentSourceId $currentDestination $currentDestinationId");

    print('date for search result = ${this.dateString}');
    http.Response response;
    _isSearching = true;
    notifyListeners();
    response = await WebService()
        .getTravels(currentSourceId, currentDestinationId, dateString);
    _isSearching = false;
    notifyListeners();
    if (handleResponse(response)) {
      final bodyResponse = json.decode(response.body);

      List<Travel> travels = bodyResponse["Data"]
          .map<Travel>((json) => Travel.fromJson(json))
          .toList();

      if (travels.isEmpty) {
        EasyLoading.showInfo('اتوبوسی برای این تاریخ وجود ندارد');
      } else {
        ResultViewModel resultViewModel =
            Provider.of<ResultViewModel>(context, listen: false);
        resultViewModel.travels = travels;
        Navigator.of(context).pushNamed('/ResultView');
      }

      print('travel length = ${travels.length}');
    }

    return false;
  }

  ////////////////////////////////////

  void setCurrentDateController(TextEditingController value) {
    _currentDateController = value;
    notifyListeners();
  }

  void setTodayDate() {
    DateTime now = DateTime.now();
    _currentDate = getShamsiDate(now.toString().substring(0, 10));
    _currentDateController.text = _currentDate;
    // notifyListeners();
  }

  String get currentDate => _currentDate;

  void setCurrentDate(String value) {
    _currentDate = value;
    notifyListeners();
  }

  Future<bool> getDestinationTownShip() async {
    http.Response response;
    try {
      response = await WebService().getAllCities();
      _isFirst = false;
    } on Exception catch (e) {
      print("getDestinationTownShip Exception $e");
      _noInternet = true;
      _isFirst = false;
      notifyListeners();
      return false;
    }

    if (handleResponse(response)) {
      final bodyResponse = json.decode(response.body);
      var data = bodyResponse["Data"];
      var dataList = data as List;
      capitalCitiesJson = data as List;
      _capitalSourceTownsList = <String>[];
      _capitalSourceTownsListID = <int>[];
      for (int i = 0; i < dataList.length; i++) {
        _capitalSourceTownsList.add(dataList[i]["title"]);
        _capitalSourceTownsListID.add(dataList[i]["id"]);
        print('dataList[i] adding list ---> ${dataList[i]}');
      }
      _capitalDestinationTownsList = [];
      _capitalDestinationTownsListID = [];
      _capitalDestinationTownsList = _capitalSourceTownsList;
      _capitalDestinationTownsListID = _capitalSourceTownsListID;
      return true;
    }
    return false;
  }

  List<String> get capitalDestinationTownsList => _capitalDestinationTownsList;

  void setCapitalDestinationTownsList(List<String> value) {
    _capitalDestinationTownsList = value;
    notifyListeners();
  }

  List<String> get capitalSourceTownsList => _capitalSourceTownsList;

  void setCapitalSourceTownsList(List<String> value) {
    _capitalSourceTownsList = value;
    notifyListeners();
  }

  void onSourceTextChanged(String text) {
    if (getCapitalCityIdByName(text) != -1) {
      setCurrentCapitalSource(text);
    } else {
      currentSource = null;
      notifyListeners();
    }
  }

  void onDestTextChanged(String text) {
    if (getCapitalCityIdByName(text) != -1) {
      setCurrentCapitalDestination(text);
    } else {
      currentDestination = null;
      notifyListeners();
    }
  }

  int getCapitalCityIdByName(String name) {
    for (int i = 0; i < _capitalSourceTownsList.length; i++) {
      if (_capitalSourceTownsList[i] == name) return i;
    }
    return -1;
  }

  void setCurrentCapitalSource(String ss) {
    setCurrentSourceId(getCapitalCityIdByName(ss));
    currentSource = ss;
    notifyListeners();
  }

  void setCurrentCapitalDestination(String ss) {
    setCurrentDestinationId(getCapitalCityIdByName(ss));
    currentDestination = ss;
    notifyListeners();
  }

  getCapitalCityID(String city, bool source) {
    int counter = 0;
    _capitalSourceTownsList.forEach((String item) {
      if (item == city) {
        source
            ? currentSourceId = _capitalDestinationTownsListID[counter]
            : currentDestinationId = _capitalDestinationTownsListID[counter];
        return;
      }
      counter++;
    });
  }

  toggleRoundTrip(value) {
    _isRoundTrip = value;
    print('_isRoundTrip = $_isRoundTrip');
    notifyListeners();
  }

  void reload(BuildContext context) {
    init(context);
  }

  String setGregorianDate2(String date) {
    print("setGregorianDate");
    print("_currentDateController test = $date");
    if (date == null || date == '') return null;

    int currentYear = int.parse(convertNumbers(date.substring(0, 4)));

    int currentMonth = int.parse(convertNumbers(date.substring(5, 7)));

    int currentDay = int.parse(convertNumbers(date.substring(8, 10)));
    print("day = $currentDay");

    PersianDate persianDate = PersianDate();
    String month = "$currentMonth", day = "$currentDay";
    if (currentMonth.toString().length < 2) {
      month = "0$currentMonth";
    }
    if (currentDay.toString().length < 2) {
      day = "0$currentDay";
    }
    String dateString = "$currentYear-$month-$day 19:54";
    print('dateString = $dateString');
    // dateString = persianDate.jalaliToGregorian(dateString).toString();
    dateString = persianDate
        .jalaliToGregorian(currentYear, int.parse(month), int.parse(day), '-')
        .toString();

    print('dateString is ---> $dateString');
    // dateString = dateString.substring(0, 10);
    print('dateString is  sub string---> $dateString');
    if (authServiceType == AuthServiceType.mock) {
      dateString = "2020-07-19"; //1399/04/29
    }

    return dateString;
  }
}
