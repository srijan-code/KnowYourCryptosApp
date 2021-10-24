import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'favourite.dart';


// ignore: must_be_immutable
class FavCoinCard extends StatefulWidget {
  FavCoinCard({
    required this.id,
    required this.name,
    required this.symbol,
    required this.imageUrl,

  });
  int id;
  String name;
  String symbol;
  String imageUrl;


  @override
  _FavCoinCardState createState() => _FavCoinCardState();
}

class _FavCoinCardState extends State<FavCoinCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color:  Colors.grey,

              offset: Offset(4, 4),
              blurRadius: 10,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(-4, -4),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(4, 4),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-4, -4),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                height: 60,
                width: 60,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.network(widget.imageUrl),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        widget.name,
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      widget.symbol,
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
               padding: const EdgeInsets.all(15.0),
             child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.end,
             children: [

               InkWell(
                 child: Text(
              'DELETE',
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
              ),
            ),
                 onTap: () async
                 {
                   await DataBaseHelper.instance.delete(widget.id);
                   Navigator.of(context).pop();
                 },
               ),


          ],
        ),
            ),
          ],

        ),
      ),
    );
  }
}