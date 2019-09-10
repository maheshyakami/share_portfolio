import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:share_portfolio/data/database/portfolio_database.dart';

@immutable
abstract class ShareState extends Equatable {
  ShareState([List props = const []]) : super(props);
}

class InitialShareBlocState extends ShareState {}

class ShareLoading extends ShareState {}

class ShareEmpty extends ShareState {}

class ShareOperationSuccess extends ShareState {
  final String message;

  ShareOperationSuccess(this.message);
}

class ShareOperationFailure extends ShareState {
  final String message;

  ShareOperationFailure(this.message);
}

class ShowShares extends ShareState {
  final List<Share> shares;
  final List<Company> companies;

  ShowShares(this.shares, this.companies);
}
