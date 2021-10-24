final String tableCrypto='crypto';
class FavCryptoFields{
  static final List<String> values = [
    id,name,symbol,imageURL
  ];

  static final String id='_id';
  static final String name='_name';
  static final String symbol='_symbol';
  static final String imageURL='_imageURL';
}
class FavCrypto{
  final int? id;
   final String name;
   final String symbol;
   final String imageURL;
  FavCrypto({required this.id,required this.name,required this.symbol,required this.imageURL});

  static FavCrypto fromJson(Map<String,Object?> json) =>
     FavCrypto (
       id: json[FavCryptoFields.id] as int?,
       name: json[FavCryptoFields.name] as String,
       symbol: json[FavCryptoFields.symbol] as String,
       imageURL: json[FavCryptoFields.imageURL] as String,

      );

  Map<String,Object?> toJson() => {
    FavCryptoFields.id:id,
    FavCryptoFields.name:name,
    FavCryptoFields.symbol:symbol,
    FavCryptoFields.imageURL:imageURL
  };
  FavCrypto copy({int? id,
    String? name,
    String? symbol,
    String? imageURL

  }) => FavCrypto(id: id?? this.id,
      name: name?? this.name,
      symbol: symbol?? this.symbol,
      imageURL: imageURL?? this.imageURL

  );

}