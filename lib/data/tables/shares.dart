import 'package:moor_flutter/moor_flutter.dart';
import 'package:share_portfolio/data/database/portfolio_database.dart';

part 'shares.g.dart';

class Shares extends Table {
  TextColumn get name => text()();

  IntColumn get units => integer()();

  TextColumn get type => text()();

  TextColumn get boughtDate => text()();

  RealColumn get boughtPrice => real()();

  @override
  Set<Column> get primaryKey => {
        name,
        type,
      };
}

@UseDao(tables: [Shares])
class ShareDao extends DatabaseAccessor<PortfolioDatabase>
    with _$ShareDaoMixin {
  ShareDao(PortfolioDatabase db) : super(db);

  Future<List<Share>> allShares() => select(shares).get();

  Future<int> insertShare(Insertable<Share> share) =>
      into(shares).insert(share, orReplace: true);

  Future<bool> updateShare(Insertable<Share> share) =>
      update(shares).replace(share);

  Future<int> deleteShare(Insertable<Share> share) =>
      delete(shares).delete(share);
}
