import 'dart:async';
import 'dart:convert';

import 'package:know_your_cryptos/favourite.dart';

import 'coinCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'coinInfo.dart';

import 'coinModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Coin>> fetchCoin() async {
    coinList = [];
    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&page=1&sparkline=false'));

    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            coinList.add(Coin.fromJson(map));
          }
        }
        setState(() {
          // ignore: unnecessary_statements
          coinList;
        });
      }
      return coinList;
    } else {
      throw Exception('Failed to load coins');
    }
  }

  @override
  void initState() {
    fetchCoin();
    Timer.periodic(Duration(seconds: 10), (timer) => fetchCoin());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.grey[300],
          title: Center(
            child: InkWell(
              child: Text(
                'KNOW YOUR CRYPTOS',
                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return Favourite();
                }));
              },
            ),
          ),
        ),
        body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: coinList.length,
          itemBuilder: (context, index) {
            return InkWell(
              child: CoinCard(
                name: coinList[index].name,
                symbol: coinList[index].symbol,
                imageUrl: coinList[index].imageUrl,
                price: coinList[index].price.toDouble(),
                change: coinList[index].change.toDouble(),
                changePercentage: coinList[index].changePercentage.toDouble(),
                marketCap: coinList[index].marketCap.toDouble(),
              ),
              onTap: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return CoinInfo(name:coinList[index].name,symbol:coinList[index].symbol,imageUrl:coinList[index].imageUrl,
                      price: coinList[index].price.toDouble(),change: coinList[index].change.toDouble(),
                      changePercentage: coinList[index].changePercentage.toDouble(),marketCap:coinList[index].marketCap.toDouble() );
                }));
              },
            );
          },
        ),
    );
  }
}