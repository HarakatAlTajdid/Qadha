import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:qadha/services/authentication_service.dart';

final locator = GetIt.instance;

@injectableInit
void setupLocator() {
  locator.registerLazySingleton(() => AuthenticationService());
}