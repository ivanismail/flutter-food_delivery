class BaseURL {
  static String domain = "https://tokovenia.com/";
  static String baseURL = domain + "fooddelivery/";
  static String baseURLImg = domain + "fooddelivery/assets/produk/";

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
}
