import 'package:flutter/material.dart';
import 'package:bitcoin_ticker_flutter/services/coin_data.dart';
import 'package:bitcoin_ticker_flutter/services/networking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

  // Create dropdownItems via coin_data currency list
  List<DropdownMenuItem<String>> getDropdownItems() {
    List<DropdownMenuItem<String>> dropdownItems = [];

    for (String currency in currenciesList) {
      var menuItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );

      dropdownItems.add(menuItem);
    }

    return dropdownItems;
  }

  // Create pickerItems via coin_data currency list
  List<Widget> getPickerItems() {
    List<Text> pickerItems = [];

    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }
    return pickerItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlueAccent,
            child: CupertinoPicker(
              backgroundColor: Colors.lightBlueAccent,
              itemExtent: 32.0, // height of each item (in px)
              onSelectedItemChanged: (selectedIndex) {
                print(selectedIndex);
              },
              children: getPickerItems(),
            ),
          ),
        ],
      ),
    );
  }
}

// DropdownButton<String>(
// value: selectedCurrency,
// onChanged: (value) {
// setState(() {
// selectedCurrency = value.toString();
// print(value);
// });
// },
// items: getDropdownItems(),
// ),
