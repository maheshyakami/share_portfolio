import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:share_portfolio/data/database/portfolio_database.dart';
import 'package:share_portfolio/services/nepse_service.dart';
import '../../singletons.dart';
import './bloc.dart';
import 'dart:io';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  @override
  CompanyState get initialState => InitialCompanyState();

  @override
  Stream<CompanyState> mapEventToState(
    CompanyEvent event,
  ) async* {
    if (event is Grab) {
      yield CompanyLoading();
      List<Company> companies;
      try {
        companies = await NEPSEService.liveData();
      } on SocketException catch (e) {
        print(e.message);
        companies =
            await getIt<PortfolioDatabase>().companiesDao.getCompanies();
      } finally {
        yield ShowCompanies(companies);
      }
    }
  }
}
