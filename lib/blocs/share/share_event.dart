import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:share_portfolio/data/database/portfolio_database.dart';

@immutable
abstract class ShareEvent extends Equatable {
  ShareEvent([List props = const []]) : super(props);
}

class GrabShares extends ShareEvent {}

class GrabCompanies extends ShareEvent {}

class Insert extends ShareEvent {
  final Share share;

  Insert(this.share);
}

class Delete extends ShareEvent {
  final Share share;

  Delete(this.share);
}

class Update extends ShareEvent {
  final Share share;

  Update(this.share);
}
