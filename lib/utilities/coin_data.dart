import 'dart:convert';
import 'package:http/http.dart' as http;

const coinAPIURL = 'https://min-api.cryptocompare.com/data/pricemulti';

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
  'TRY',
  'USD',
  'ZAR'
];

const List<String> cryptoList = ['BTC', 'LTC', 'ETH', 'BCH', 'XRP', 'EOS'];

var decodedData;

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};
    String requestURL =
        '$coinAPIURL?fsyms=${cryptoList.join(",")}&tsyms=${currenciesList.join(",")}';
    print(requestURL);

    http.Response response = await http.get(requestURL);

    if (response.statusCode == 200) {
      decodedData = jsonDecode(response.body);

      for (String crypto in cryptoList) {
        var price = decodedData[crypto][selectedCurrency];
        cryptoPrices[crypto] = price.toString();
      }
    } else {
      print(response.statusCode);
      throw 'Problem with the get request';
    }
    return cryptoPrices;
  }

  Map getDecodedData(String selectedCurrency) {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      var price = decodedData[crypto][selectedCurrency];
      cryptoPrices[crypto] = price.toString();
    }
    return cryptoPrices;
  }
}
