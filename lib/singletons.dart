import 'package:get_it/get_it.dart';
import 'package:share_portfolio/data/database/portfolio_database.dart';

GetIt getIt = GetIt();

class Singletons {
  static void register() {
    getIt.registerSingleton(PortfolioDatabase());
  }
}
