import 'package:flutter/material.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrencyTo = 'BTC';
  String selectedCurrencyFrom = 'USD';
  String url;
  String _value = '?';
  CoinData coinData = CoinData();
  List<DropdownMenuItem> getDropdownList() {
    List<DropdownMenuItem> listItems = [];
    for (var i = 0; i < currenciesList.length; i++) {
      listItems.add(
        DropdownMenuItem(
          child: Text(
            currenciesList[i],
          ),
          value: currenciesList[i],
        ),
      );
    }
    return listItems;
  }

  void getValue() async {
    _value = await coinData.getCoinData(
        url, selectedCurrencyFrom, selectedCurrencyTo);
  }

  @override
  void initState() {
    url =
        'https://rest.coinapi.io/v1/exchangerate/$selectedCurrencyFrom/$selectedCurrencyTo';
    getValue();
    super.initState();
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
          Expanded(
            child: Card(
              margin: EdgeInsets.all(0),
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '1 $selectedCurrencyFrom',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 80.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Equals',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 80.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '$_value $selectedCurrencyTo',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 80.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                DropdownButton(
                  itemHeight: 50,
                  style: TextStyle(fontSize: 40),
                  value: selectedCurrencyFrom,
                  items: getDropdownList(),
                  onChanged: (value) async {
                    selectedCurrencyFrom = value;
                    url =
                        'https://free.currconv.com/api/v7/convert?q=${selectedCurrencyFrom}_$selectedCurrencyTo&compact=ultra&apiKey=ef07754046bb28679370';
                    selectedCurrencyTo == selectedCurrencyFrom
                        ? _value = '1'
                        : _value = await coinData.getCoinData(
                            url, selectedCurrencyFrom, selectedCurrencyTo);
                    setState(() {});
                  },
                ),
                Text(
                  'TO',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                  ),
                ),
                DropdownButton(
                  style: TextStyle(fontSize: 40),
                  value: selectedCurrencyTo,
                  items: getDropdownList(),
                  onChanged: (value) async {
                    selectedCurrencyTo = value;
                    url =
                        'https://free.currconv.com/api/v7/convert?q=${selectedCurrencyFrom}_$selectedCurrencyTo&compact=ultra&apiKey=ef07754046bb28679370';
                    selectedCurrencyTo == selectedCurrencyFrom
                        ? _value = '1'
                        : _value = await coinData.getCoinData(
                            url, selectedCurrencyFrom, selectedCurrencyTo);
                    setState(() {});
                    print(_value);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
