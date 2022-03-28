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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_model.dart';

abstract class MembershipDashboardListState extends Equatable {
  const MembershipDashboardListState();

  @override
  List<Object?> get props => [];
}

class MembershipDashboardListLoading extends MembershipDashboardListState {}

class MembershipDashboardListLoaded extends MembershipDashboardListState {
  final List<MembershipDashboardModel?>? values;
  final bool? mightHaveMore;

  const MembershipDashboardListLoaded({this.mightHaveMore, this.values = const []});

  @override
  List<Object?> get props => [ values, mightHaveMore ];

  @override
  String toString() => 'MembershipDashboardListLoaded { values: $values }';

  @override
  bool operator ==(Object other) => 
          other is MembershipDashboardListLoaded &&
              runtimeType == other.runtimeType &&
              ListEquality().equals(values, other.values) &&
              mightHaveMore == other.mightHaveMore;
}

class MembershipDashboardNotLoaded extends MembershipDashboardListState {}

