import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:share_portfolio/blocs/share/bloc.dart';
import 'package:share_portfolio/data/database/portfolio_database.dart';
import 'package:share_portfolio/widgets/portfolio_appbar.dart';
import 'package:share_portfolio/widgets/portfolio_flushbar.dart';

import '../portfolio_colors.dart';
import 'add_share_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ShareBloc>(context).dispatch(GrabShares());
    return Scaffold(
      appBar: PortfolioAppBar(
        title: Text('Stock Portfolio'),
      ),
      floatingActionButton: _fab(),
      body: BlocListener<ShareBloc, ShareState>(
        listener: (context, state) {
          if (state is ShareOperationSuccess) {
            portfolioFlushBar(context: context, message: state.message);
          }
          if (state is ShareOperationFailure) {
            portfolioFlushBar(context: context, message: state.message);
          }
        },
        child: BlocBuilder<ShareBloc, ShareState>(
          builder: (context, state) {
            if (state is ShareLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ShareEmpty) {
              return Center(
                child: Text(
                  'It\'s Lonely Here...',
                  style: Theme.of(context).textTheme.display1.copyWith(
                        color: PortfolioColors.pink,
                      ),
                ),
              );
            }
            if (state is ShowShares) {
              return RefreshIndicator(
                onRefresh: () async =>
                    BlocProvider.of<ShareBloc>(context).dispatch(GrabShares()),
                child: ListView.builder(
                  itemBuilder: (context, index) => ShareDetailCard(
                    share: state.shares[index],
                    ltp: state.companies
                        .firstWhere((company) =>
                            company.name == state.shares[index].name)
                        .ltp,
                  ),
                  itemCount: state.shares.length,
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _fab() => FloatingActionButton.extended(
        heroTag: 'add',
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddShareScreen(),
          ),
        ),
        icon: Icon(Icons.add),
        label: Text('ADD'),
      );
}

class ShareDetailCard extends StatelessWidget {
  final Share share;
  final double ltp;

  const ShareDetailCard({
    this.share,
    this.ltp,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableBehindActionPane(),
      child: Card(
        margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 4.0,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Marquee(
                      textDirection: TextDirection.ltr,
                      pauseDuration: Duration(seconds: 0),
                      child: Text(
                        share.name ?? '',
                        style: TextStyle(
                          color: PortfolioColors.pink,
                          fontWeight: FontWeight.w300,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 40.0),
                  Text(
                    '${share.units} units',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Text(
                '${NepaliDateFormatter("MMMM d, y").format(
                  NepaliDateTime.tryParse(share.boughtDate) ??
                      NepaliDateTime(2000),
                )} | ${share.type}',
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: PortfolioColors.pink[100],
                    ),
              ),
              Divider(),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _shareInsight(
                    title: 'Purchase Value',
                    value: _purchaseValue(share.units, share.boughtPrice),
                  ),
                  _shareInsight(
                    title: 'Present Value',
                    value: _presentValue(share.units),
                  ),
                  _shareInsight(
                    title: 'Increment',
                    value: _increment(share.units, share.boughtPrice),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      secondaryActions: [
        Padding(
          padding: EdgeInsets.only(top: 9.0),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
            ),
            child: IconSlideAction(
              color: PortfolioColors.pink[100],
              icon: Icons.edit,
              foregroundColor: Colors.white,
              caption: 'Update',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddShareScreen(share),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 9.0, right: 10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
            child: IconSlideAction(
              color: PortfolioColors.pink,
              icon: Icons.delete,
              foregroundColor: Colors.white,
              caption: 'Delete',
              onTap: () => _deleteConfirmationDialog(context),
            ),
          ),
        ),
      ],
    );
  }

  String _purchaseValue(int units, double purchasePrice) =>
      'Rs. ${(units * purchasePrice).toStringAsFixed(2)}';

  String _presentValue(int units) =>
      'Rs. ${(units * (ltp ?? 0.0)).toStringAsFixed(2)}';

  String _increment(int units, double purchasePrice) {
    double numerator = units * (ltp ?? 0.0);
    double denominator = units * purchasePrice;
    return '${numerator > denominator ? '+' : '-'} ${((denominator - numerator).abs() / denominator * 100).toStringAsFixed(2)} %';
  }

  Widget _shareInsight({
    String title,
    String value = '',
  }) {
    return Flexible(
      flex: 1,
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w200,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 15.0,
              color: value.contains('+') || value.contains('-')
                  ? value.contains('+') ? Colors.green : Colors.red
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  void _deleteConfirmationDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 15.0),
              Icon(
                Icons.delete_outline,
                color: PortfolioColors.pink,
                size: 50.0,
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.0),
                  child: Text(
                    'Are you sure to delete?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: PortfolioColors.pink,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              Row(
                children: [
                  Expanded(
                    child: Material(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                        ),
                      ),
                      child: InkWell(
                        splashColor: PortfolioColors.pink,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                        ),
                        onTap: () {
                          BlocProvider.of<ShareBloc>(context)
                              .dispatch(Delete(share));
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'DELETE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      color: PortfolioColors.pink[100],
                    ),
                  ),
                  Expanded(
                    child: Material(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10.0),
                        ),
                      ),
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10.0),
                        ),
                        splashColor: PortfolioColors.pink[100],
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'CANCEL',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      color: PortfolioColors.pink,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
