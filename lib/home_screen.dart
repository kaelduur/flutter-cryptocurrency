import 'package:flutter/material.dart';
import 'package:flutter_cryptocurrency/utilities/constants.dart';
import 'package:flutter_cryptocurrency/utilities/coin_data.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCurrency = 'USD';

  Map<String, String> coinValues = {};
  bool isWaiting = false;

  void getData() async {
    isWaiting = true;
    try {
      var data = await CoinData().getCoinData(selectedCurrency);
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  void changeCurrency() {
    isWaiting = true;
    try {
      var data = CoinData().getDecodedData(selectedCurrency);
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          makeCards(),
          Container(
            height: 50.0,
            alignment: Alignment.center,
            color: Color(0xFF76B4EB),
            child: currencyDropdown(),
          )
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kBackGroundColor,
      elevation: 0,
      actions: <Widget>[
        IconButton(
          iconSize: 27.5,
          highlightColor: Colors.transparent,
          splashRadius: 27.5,
          icon: Icon(
            Icons.refresh,
            color: Colors.white,
          ),
          onPressed: () {
            getData();
          },
        )
      ],
    );
  }

  Column makeCards() {
    List<CryptoCard> cryptoCards = [];
    for (String crypto in cryptoList) {
      cryptoCards.add(CryptoCard(
        cryptoCurrency: crypto,
        selectedCurrency: selectedCurrency,
        value: isWaiting ? '?' : coinValues[crypto],
      ));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cryptoCards,
    );
  }

  DropdownButtonHideUnderline currencyDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(
          currency,
          style: kDropdownTextStyle,
        ),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        dropdownColor: Color(0xFF4D5C6A),
        value: selectedCurrency,
        items: dropdownItems,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value;
            changeCurrency();
          });
        },
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    this.value,
    this.selectedCurrency,
    this.cryptoCurrency,
  });

  final String value;
  final String selectedCurrency;
  final String cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: kBackGroundColor,
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 27.5,
              backgroundImage:
                  AssetImage('images/${cryptoCurrency.toLowerCase()}.png'),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              '$cryptoCurrency',
              style: kCoinTextStyle,
            ),
            Expanded(
              flex: 1,
              child: Text(
                '$value $selectedCurrency',
                style: kCoinTextStyle,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
