import 'package:food_delivery/src/repository/AuthRepo.dart';

class AuthBloc {
  final _authRepo = AuthRepo();

  getValidateEmail(String email) {
    return _authRepo.getValidateEmail(email);
  }

  login(String email, String password) {
    return _authRepo.login(email, password);
  }

  register(String nama, String no_telp, String email, String password) {
    return _authRepo.register(nama, no_telp, email, password);
  }

  savePassword(String id, String password) {
    return _authRepo.savePassword(id, password);
  }
}

final authBloc = AuthBloc();
