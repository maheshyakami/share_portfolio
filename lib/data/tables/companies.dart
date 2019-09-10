import 'package:moor_flutter/moor_flutter.dart';
import 'package:share_portfolio/data/database/portfolio_database.dart';

part 'companies.g.dart';

@DataClassName("Company")
class Companies extends Table {
  TextColumn get name => text()();

  RealColumn get ltp => real()();

  @override
  Set<Column> get primaryKey => {name};
}

@UseDao(tables: [Companies])
class CompaniesDao extends DatabaseAccessor<PortfolioDatabase>
    with _$CompaniesDaoMixin {
  CompaniesDao(PortfolioDatabase db) : super(db);
  Future<List<Company>> getCompanies() => select(companies).get();

  Future<void> syncCompanies(List<Company> companiesData) async {
    for (var company in companiesData)
      await into(companies).insert(company, orReplace: true);
  }
}
