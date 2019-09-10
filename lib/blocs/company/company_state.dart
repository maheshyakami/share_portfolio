import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:share_portfolio/data/database/portfolio_database.dart';

@immutable
abstract class CompanyState extends Equatable {
  CompanyState([List props = const []]) : super(props);
}

class InitialCompanyState extends CompanyState {}

class CompanyLoading extends CompanyState {}

class ShowCompanies extends CompanyState {
  final List<Company> companies;

  ShowCompanies(this.companies);
}
