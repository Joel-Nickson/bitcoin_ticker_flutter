import 'package:flutter/material.dart';
import '/coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String selectedCrypto = 'BTC';
  // String cryptoCoinValue = '?';
  String bitCoinValue = '?';
  String ethCoinValue = '?';
  String ltcCoinValue = '?';

  // CupertinoPicker iOSPicker() {
  //   List<Text> pickerItems = [];
  //   for (String currency in currenciesList) {
  //     pickerItems.add(Text(currency));
  //   }

  //   return CupertinoPicker(
  //     itemExtent: 32.0,
  //     onSelectedItemChanged: (s) {
  //       setState(() {
  //         selectedCurrency = currenciesList[s];
  //         getData(selectedCurrency);
  //       });
  //     },
  //     children: pickerItems,
  //   );
  // }

  DropdownButton<String> androidDropDown() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      dropDownItems.add(
        DropdownMenuItem(
          child: Center(child: Text(currency)),
          value: currency,
        ),
      );
    }

    return DropdownButton(
      value: selectedCurrency,
      items: dropDownItems,
      icon: const Icon(Icons.keyboard_arrow_down),
      onChanged: (dynamic value) {
        setState(
          () {
            selectedCurrency = value.toString();
            getData(selectedCurrency);
          },
        );
      },
    );
  }

  void getData(selectedCurrency) async {
    double bitCoinData, ethCoinData, ltcCoinData;
    try {
      bitCoinData =
          await CoinData().getCoinData(selectedCurrency, cryptoList[0]);
      ethCoinData =
          await CoinData().getCoinData(selectedCurrency, cryptoList[1]);
      ltcCoinData =
          await CoinData().getCoinData(selectedCurrency, cryptoList[2]);

      setState(() {
        bitCoinValue = bitCoinData.toStringAsFixed(0);
        ethCoinValue = ethCoinData.toStringAsFixed(0);
        ltcCoinValue = ltcCoinData.toStringAsFixed(0);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData(selectedCurrency);
  }

  Widget CryptoUI(selectedCrypto, cryptoCoinValue) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $selectedCrypto = $cryptoCoinValue $selectedCurrency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CryptoUI(cryptoList[0], bitCoinValue),
                CryptoUI(cryptoList[1], ethCoinValue),
                CryptoUI(cryptoList[2], ltcCoinValue),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: androidDropDown(),
          ),
        ],
      ),
    );
  }
}
