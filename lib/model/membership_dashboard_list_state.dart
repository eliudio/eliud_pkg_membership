/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 membership_dashboard_list_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_model.dart';

abstract class MembershipDashboardListState extends Equatable {
  const MembershipDashboardListState();

  @override
  List<Object> get props => [];
}

class MembershipDashboardListLoading extends MembershipDashboardListState {}

class MembershipDashboardListLoaded extends MembershipDashboardListState {
  final List<MembershipDashboardModel> values;

  const MembershipDashboardListLoaded({this.values = const []});

  @override
  List<Object> get props => [ values ];

  @override
  String toString() => 'MembershipDashboardListLoaded { values: $values }';
}

class MembershipDashboardNotLoaded extends MembershipDashboardListState {}
