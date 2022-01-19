import 'package:flutter/material.dart';
import 'package:bitcoin_ticker_flutter/services/coin_data.dart';
import 'package:bitcoin_ticker_flutter/services/networking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;

const String coinExchangeURL =
    'https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=';
const String apiKey = '1C349635-A53A-4B2C-9A8A-0CF273FDE49C';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  // CoinData btcCoinData = CoinData(crypto: 'BTC', currency: 'USD');
  CoinModel coinModel = CoinModel();
  double btcPriceUSD = 0.0;
  double btcPrice = 0.0;

  String selectedCurrency = 'USD';

  void updateUI(dynamic coinData) {
    setState(() {
      if (coinData == null) {
        btcPriceUSD = -666.0;
      }
      btcPriceUSD = coinData['rate'];
      // coinData.getExchangeRate();
      // btcPriceUSD = btcCoinData
    });
  }

  // Create DropdownButton (Android) with dropdownItems via coin_data currency list
  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];

    for (String currency in currenciesList) {
      var menuItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );

      dropdownItems.add(menuItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      onChanged: (value) async {
        selectedCurrency = value.toString();
        var coinData = await coinModel.getExchangeRate('BTC', selectedCurrency);
        updateUI(coinData);
        print(selectedCurrency);
      },
      items: dropdownItems,
    );
  }

  // Create CupertinoPicker with pickerItems via coin_data currency list
  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];

    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlueAccent,
      itemExtent: 32.0, // height of each item (in px)
      onSelectedItemChanged: (selectedIndex) async {
        selectedCurrency = currenciesList[selectedIndex];
        var coinData = await coinModel.getExchangeRate('BTC', selectedCurrency);
        updateUI(coinData);
        print(selectedCurrency);
      },
      children: pickerItems,
    );
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
                  '1 BTC = $btcPriceUSD $selectedCurrency',
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
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
