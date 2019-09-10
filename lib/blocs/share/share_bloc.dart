import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:share_portfolio/data/database/portfolio_database.dart';
import 'package:share_portfolio/services/nepse_service.dart';

import '../../singletons.dart';
import './bloc.dart';

class ShareBloc extends Bloc<ShareEvent, ShareState> {
  @override
  ShareState get initialState => InitialShareBlocState();

  @override
  Stream<ShareState> mapEventToState(
    ShareEvent event,
  ) async* {
    if (event is GrabShares) {
      yield ShareLoading();
      List<Share> shares;
      shares = await getIt<PortfolioDatabase>().shareDao.allShares();

      List<Company> companies;
      try {
        companies = await NEPSEService.liveData();
        getIt<PortfolioDatabase>().companiesDao.syncCompanies(companies);
      } on SocketException catch (e) {
        print(e.message);
        companies =
            await getIt<PortfolioDatabase>().companiesDao.getCompanies();
      } finally {
        yield ShowShares(shares, companies);
        if (shares.isEmpty) {
          yield ShareEmpty();
        }
      }
    }
    if (event is Insert) {
      try {
        await getIt<PortfolioDatabase>().shareDao.insertShare(event.share);
        yield ShareOperationSuccess('Inserted Successfully!');
      } on InvalidDataException catch (e) {
        yield ShareOperationFailure(e.message);
      } finally {
        dispatch(GrabShares());
      }
    }
    if (event is Update) {
      try {
        await getIt<PortfolioDatabase>().shareDao.updateShare(event.share);
        yield ShareOperationSuccess('Updated Successfully!');
      } on InvalidDataException catch (e) {
        yield ShareOperationFailure(e.message);
      } finally {
        dispatch(GrabShares());
      }
    }
    if (event is Delete) {
      try {
        await getIt<PortfolioDatabase>().shareDao.deleteShare(event.share);
        yield ShareOperationSuccess('Deleted Successfully!');
      } on InvalidDataException catch (e) {
        yield ShareOperationFailure(e.message);
      } finally {
        dispatch(GrabShares());
      }
    }
  }
}
