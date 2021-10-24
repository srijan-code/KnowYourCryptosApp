
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'database_helper.dart';
import 'db_crypto.dart';
import 'favCoinCard.dart';
import 'coinInfo.dart';

import 'dart:convert';

class Favourite extends StatefulWidget {


  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {


  late List<FavCrypto> favcryptos;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshFavCryptos();
  }



  Future refreshFavCryptos() async
  {
    setState(() {
      isLoading = true;
    });
    this.favcryptos = await DataBaseHelper.instance.readAllFavCrypto();

    setState(() {
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Center(
          child: Text(

            'Your Favourite ones',
            style: TextStyle(fontSize: 24),



          ),
        ),

      )
      ,
      body: Center(
        child: isLoading ? CircularProgressIndicator() : favcryptos.isEmpty
            ? Text(
          'No Favourite Crypto added',
          style: TextStyle(color: Colors.blueGrey),
        ) :
        ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: favcryptos.length,
          itemBuilder: (context, index) {
            return InkWell(

              child: FavCoinCard(
                id: favcryptos[index].id?? 1,
                name: favcryptos[index].name,
                symbol: favcryptos[index].symbol,
                imageUrl: favcryptos[index].imageURL,

              ),



            );
          },
        ),
      ),

    );
  }
}