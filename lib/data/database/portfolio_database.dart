import 'package:moor_flutter/moor_flutter.dart';
import 'package:share_portfolio/data/tables/companies.dart';

import '../tables/shares.dart';

part 'portfolio_database.g.dart';

@UseMoor(tables: [
  Shares,
  Companies,
], daos: [
  ShareDao,
  CompaniesDao,
])
class PortfolioDatabase extends _$PortfolioDatabase {
  PortfolioDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
          path: 'portfolio.db',
          logStatements: false,
        ));

  @override
  int get schemaVersion => 1;
}
