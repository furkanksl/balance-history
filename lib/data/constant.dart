class Urls {
  static const String baseUrl =
      'https://api.blockcypher.com/v1/btc/test3/addrs';

  static const String apiToken = '89f18034645e48109298ad1a0f8b6cf5';

  static const String defaultAddress = 'mhmXNghgp9LudtXZJ6Wxp3qXDVHeeX5bCW';

  static String getHistoryByAddress(String address) =>
      '$baseUrl/$address?token=$apiToken';
}
