import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:share_portfolio/blocs/company/bloc.dart';
import 'package:share_portfolio/blocs/share/bloc.dart';
import 'package:share_portfolio/data/database/portfolio_database.dart';
import 'package:share_portfolio/widgets/custom_dropdown.dart';
import 'package:share_portfolio/widgets/portfolio_appbar.dart';

import '../portfolio_colors.dart';

class AddShareScreen extends StatefulWidget {
  final Share share;

  AddShareScreen([
    this.share,
  ]);

  @override
  _AddShareScreenState createState() => _AddShareScreenState();
}

class _AddShareScreenState extends State<AddShareScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _boughtPriceController;

  TextEditingController _unitsController;

  ValueNotifier<String> _selectedCompanyName;

  ValueNotifier<String> _selectedShareType;

  ValueNotifier<NepaliDateTime> _selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.share == null) {
      _boughtPriceController = TextEditingController();
      _unitsController = TextEditingController();
      _selectedCompanyName = ValueNotifier<String>(null);
      _selectedShareType = ValueNotifier<String>(null);
      _selectedDate = ValueNotifier<NepaliDateTime>(NepaliDateTime.now());
    } else {
      _boughtPriceController =
          TextEditingController(text: '${widget.share.boughtPrice}');
      _unitsController = TextEditingController(text: '${widget.share.units}');
      _selectedCompanyName = ValueNotifier<String>('${widget.share.name}');
      _selectedShareType = ValueNotifier<String>('${widget.share.type}');
      _selectedDate = ValueNotifier<NepaliDateTime>(
          NepaliDateTime.tryParse(widget.share.boughtDate) ??
              NepaliDateTime(2000));
    }
    BlocProvider.of<CompanyBloc>(context).dispatch(Grab());
  }

  @override
  void dispose() {
    _boughtPriceController.dispose();
    _unitsController.dispose();
    _selectedCompanyName.dispose();
    _selectedShareType.dispose();
    _selectedDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PortfolioAppBar(
        title: Hero(
          tag: 'add',
          child: Text(
            '${widget.share == null ? 'Add' : 'Update'} Share Detail',
            style: Theme.of(context).textTheme.title,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _space(),
                BlocBuilder<CompanyBloc, CompanyState>(
                  builder: (context, state) {
                    if (state is CompanyLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is ShowCompanies)
                      return ValueListenableBuilder<String>(
                        valueListenable: _selectedCompanyName,
                        builder: (context, selectedCompanyName, _) =>
                            PortfolioDropdown(
                          onChanged: (value) =>
                              _selectedCompanyName.value = value,
                          value: selectedCompanyName,
                          hint: 'Select company',
                          label: 'Company',
                          items: state.companies
                              .map(
                                (company) => DropdownMenuItem(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(company.name ?? ''),
                                  ),
                                  value: company.name,
                                ),
                              )
                              .toList(),
                        ),
                      );
                    return Container();
                  },
                ),
                _space(),
                ValueListenableBuilder<String>(
                  valueListenable: _selectedShareType,
                  builder: (context, selectedShareType, _) => PortfolioDropdown(
                    onChanged: (value) => _selectedShareType.value = value,
                    value: selectedShareType,
                    hint: 'Select share type',
                    label: 'Share Type',
                    items: [
                      'IPO',
                      'FPO',
                      'Right',
                      'Auction',
                      'Secondary Market',
                    ]
                        .map(
                          (type) => DropdownMenuItem(
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(type),
                            ),
                            value: type,
                          ),
                        )
                        .toList(),
                  ),
                ),
                _space(),
                PortfolioTextField(
                  controller: _boughtPriceController,
                  hintText: 'Enter bought price',
                  labelText: 'Bought Price',
                ),
                _space(),
                PortfolioTextField(
                  controller: _unitsController,
                  hintText: 'Enter share units',
                  labelText: 'Share Units',
                ),
                _space(),
                ValueListenableBuilder<NepaliDateTime>(
                  valueListenable: _selectedDate,
                  builder: (context, selectedDate, _) => InkWell(
                    splashColor: PortfolioColors.pink[200],
                    onTap: () async {
                      _selectedDate.value = (await showAdaptiveDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: NepaliDateTime(2000),
                            lastDate: NepaliDateTime(2090),
                          )) ??
                          selectedDate;
                    },
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Bought Date',
                      ),
                      child: Text(
                        NepaliDateFormatter("MMMM d, y (EEE)").format(
                          selectedDate ?? NepaliDateTime(2076),
                        ),
                        style: TextStyle(
                          color: Colors.pink[400],
                        ),
                      ),
                    ),
                  ),
                ),
                _space(),
                _space(),
                MaterialButton(
                  onPressed: widget.share == null ? _insertShare : _updateShare,
                  splashColor: PortfolioColors.pink[200],
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 18.0),
                    child: Text(
                      widget.share == null ? 'ADD' : 'UPDATE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  color: PortfolioColors.pink,
                ),
                _space(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _space() => SizedBox(height: 14.0);

  void _insertShare() {
    if (_formKey.currentState.validate()) {
      BlocProvider.of<ShareBloc>(context).dispatch(Insert(
        Share(
          name: _selectedCompanyName.value,
          units: int.tryParse(_unitsController.text) ?? 0,
          type: _selectedShareType.value,
          boughtDate: _selectedDate.value.toIso8601String(),
          boughtPrice: double.tryParse(_boughtPriceController.text) ?? 0.0,
        ),
      ));
      Navigator.pop(context, true);
    }
  }

  void _updateShare() {
    try {
      if (_formKey.currentState.validate()) {
        BlocProvider.of<ShareBloc>(context).dispatch(Update(
          Share(
            name: _selectedCompanyName.value,
            units: int.tryParse(_unitsController.text) ?? 0,
            type: _selectedShareType.value,
            boughtDate: _selectedDate.value.toIso8601String(),
            boughtPrice: double.tryParse(_boughtPriceController.text) ?? 0.0,
          ),
        ));
        Navigator.pop(context, true);
      }
    } catch (_) {
      Navigator.pop(context, false);
    }
  }
}

class PortfolioTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool numberMode;

  PortfolioTextField({
    this.controller,
    this.labelText,
    this.hintText,
    this.numberMode = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) => value.isEmpty ? 'Required' : null,
      controller: controller,
      keyboardType: numberMode ? TextInputType.number : TextInputType.text,
      style: TextStyle(
        color: PortfolioColors.pink[400],
      ),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
      ),
    );
  }
}

class PortfolioDropdown<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final T value;
  final void Function(T) onChanged;
  final String hint;
  final String label;

  const PortfolioDropdown({
    this.items,
    this.value,
    this.onChanged,
    this.hint,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDropdownButtonFormField<T>(
      value: value,
      onChanged: onChanged,
      isExpanded: true,
      isDense: true,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
      ),
      validator: (value) => value == null ? 'Required' : null,
      items: items,
      style: TextStyle(
        color: PortfolioColors.pink[400],
      ),
      iconEnabledColor: PortfolioColors.pink,
    );
  }
}
