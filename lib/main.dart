import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_portfolio/blocs/share/bloc.dart';
import 'package:share_portfolio/singletons.dart';

import 'blocs/company/company_bloc.dart';
import 'portfolio_colors.dart';
import 'screens/home_screen.dart';

void main() {
  Singletons.register();
  runApp(SharePortfolioApp());
}

class SharePortfolioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ShareBloc>(builder: (context) => ShareBloc()),
        BlocProvider<CompanyBloc>(builder: (context) => CompanyBloc()),
      ],
      child: MaterialApp(
        title: 'Stock Portfolio',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: PortfolioColors.pink,
          scaffoldBackgroundColor: Colors.white,
          textTheme: TextTheme(
            title: TextStyle(
              color: Colors.white,
            ),
            button: TextStyle(
              color: Colors.white,
            ),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            foregroundColor: Colors.white,
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(),
            hintStyle: TextStyle(
              color: PortfolioColors.pink[200],
            ),
          ),
          cursorColor: PortfolioColors.pink[400],
        ),
        home: HomeScreen(),
      ),
    );
  }
}
