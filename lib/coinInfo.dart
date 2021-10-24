import 'package:flutter/material.dart';
import 'package:know_your_cryptos/coinModel.dart';
import 'database_helper.dart';
import 'db_crypto.dart';
import 'dart:async';

class CoinInfo extends StatefulWidget {
  final String name ;
  final String symbol ;
  final String imageUrl;
  final num price ;
  final num change ;
  final num changePercentage;
  final num marketCap;

  CoinInfo({required this.name,required this.symbol,required this.imageUrl,
    required this.price,required this.change,required this.changePercentage,required this.marketCap});

  @override
  _CoinInfoState createState() => _CoinInfoState(name1: name,symbol1: symbol,imageUrl1: imageUrl,price1: price,change1: change,
      changePercentage1
  :changePercentage,marketCap1: marketCap);
}

class _CoinInfoState extends State<CoinInfo> {
  String name1;

  String symbol1;

  String imageUrl1;
  num price1;

  num change1;

  num changePercentage1;

  num marketCap1;



  _CoinInfoState(
      {required this.name1, required this.symbol1, required this.imageUrl1,
        required this.price1, required this.change1, required this.changePercentage1,required this.marketCap1});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(imageUrl1),
              ),
              Text(
                name1,
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pacifico',
                ),
              ),
              Text(
                symbol1,
                style: TextStyle(
                  fontFamily: 'Source Sans Pro',
                  color: Colors.teal[100],
                  fontSize: 20.0,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0,
                width: 150.0,
                child: Divider(
                  color: Colors.teal.shade100,
                ),
              ),
              Card(
                color: Colors.white,

                margin: EdgeInsets.symmetric(vertical: 10.0,
                    horizontal: 10.0),
                child: ListTile(
                  leading: Icon(Icons.money,
                    color: Colors.teal[1000],
                  ),
                  title: Text(price1.toString(),
                    style: TextStyle(
                      color: Colors.teal.shade900,
                      fontFamily: 'Source Sans Pro',
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              Card(

                color: Colors.white,

                margin: EdgeInsets.symmetric(vertical: 10.0,
                    horizontal: 10.0),
                child: ListTile(
                  leading:

                  Icon(Icons.keyboard_capslock_sharp,
                    color: Colors.teal[1000],
                  ),
                  title: Text('${marketCap1.toInt()}',
                    style: TextStyle(
                      color: Colors.teal.shade900,
                      fontFamily: 'Source Sans Pro',
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              Card(

                color: Colors.white,

                margin: EdgeInsets.symmetric(vertical: 10.0,
                    horizontal: 10.0),
                child: ListTile(
                  leading: Icon(Icons.thumbs_up_down_sharp,
                    color: Colors.teal[1000],
                  ),
                  title: Text(changePercentage1.toString(),
                    style: TextStyle(
                      color: Colors.teal.shade900,
                      fontFamily: 'Source Sans Pro',
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              Card(

                color: Colors.white,

                margin: EdgeInsets.symmetric(vertical: 10.0,
                    horizontal: 10.0),
                child: ListTile(
                  leading: Icon(Icons.favorite,
                    color: Colors.teal[1000],
                  ),
                  title: InkWell(
                    child: Text(
                      'Add to Favourites',
                      style: TextStyle(
                        color: Colors.orange.shade900,
                        fontFamily: 'Source Sans Pro',
                        fontSize: 20.0,
                      ),
                    ),
                    onTap: () async
                    {
                      final cryptos = FavCrypto(
                        id: (price1.toInt()),
                        name: name1,
                        symbol: symbol1,
                        imageURL: imageUrl1,

                      );

                      await DataBaseHelper.instance.create(cryptos);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),

      ),

    );
  }
}
