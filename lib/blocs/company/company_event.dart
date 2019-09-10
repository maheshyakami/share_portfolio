import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CompanyEvent extends Equatable {
  CompanyEvent([List props = const []]) : super(props);
}

class Grab extends CompanyEvent {}
