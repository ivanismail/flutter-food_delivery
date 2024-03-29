class BaseURL {
  static String domain = "https://apps.cindy.co.id/";
  static String baseURL = domain + "fooddelivery/";
  static String baseURLImg = domain + "fooddelivery/assets/produk/";

  static String apiKey = "7_KPQb0dn8oOrxdDqtwfZSypnGze5kFMZFxpv6DThPY";
  static String urlGetAddressHereMap =
      "https://revgeocode.search.hereapi.com/v1/revgeocode?apiKey=7_KPQb0dn8oOrxdDqtwfZSypnGze5kFMZFxpv6DThPY";

  //Produk
  static String urlGetProduk = baseURL + "get-produk";
  //Auth
  static String urlGetValidateEmail = baseURL + "get-validate-email";
  static String urlLogin = baseURL + "get-login";
  static String urlRegister = baseURL + "register";
  static String urlSavePassword = baseURL + "update-pass";
  //Keranjang
  static String urlGetCart = baseURL + "get-cart-item";
  static String urlAddCart = baseURL + "add-cart";
  static String urlupdateQtyCart = baseURL + "update-cart";
  static String urldeleteItemCart = baseURL + "delete-item-cart";
  static String urlGetTotalItem = baseURL + "get-total-item";
  //Transaksi Pemesanan
  static String urlGetTotalBayar = baseURL + "get-total-bayar";
  static String urlPostTransaction = baseURL + "add-transaction";
  static String urlGetTransaction = baseURL + "get-transaction";
  static String urlGetLogTransaction = baseURL + "get-log-transaction";
}
