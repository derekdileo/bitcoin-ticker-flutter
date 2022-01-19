import 'networking.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const String fullCoinURL =
    'https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=1C349635-A53A-4B2C-9A8A-0CF273FDE49C';
const String coinURL = 'https://rest.coinapi.io/v1/exchangerate/';
const String btcQuery = 'GET /v1/exchangerate/BTC?apikey=';
const String apiKey = '1C349635-A53A-4B2C-9A8A-0CF273FDE49C';

class CoinModel {
  Future<dynamic> getExchangeRate(String crypto, String currency) async {
    // Generate a Uri for API call
    var url = Uri.parse('$coinURL$crypto/$currency?apikey=$apiKey');

    // Instantiate NetworkHelper object with Uri
    NetworkHelper networkHelper = NetworkHelper(url);

    // Gather jsonDecoded weatherData
    var coinData = await networkHelper.getData();

    return coinData;
  }
}
