/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 membership_dashboard_component_state.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_model.dart';

abstract class MembershipDashboardComponentState extends Equatable {
  const MembershipDashboardComponentState();

  @override
  List<Object?> get props => [];
}

class MembershipDashboardComponentUninitialized
    extends MembershipDashboardComponentState {}

class MembershipDashboardComponentError
    extends MembershipDashboardComponentState {
  final String? message;
  MembershipDashboardComponentError({this.message});
}

class MembershipDashboardComponentPermissionDenied
    extends MembershipDashboardComponentState {
  MembershipDashboardComponentPermissionDenied();
}

class MembershipDashboardComponentLoaded
    extends MembershipDashboardComponentState {
  final MembershipDashboardModel value;

  const MembershipDashboardComponentLoaded({required this.value});

  MembershipDashboardComponentLoaded copyWith(
      {MembershipDashboardModel? copyThis}) {
    return MembershipDashboardComponentLoaded(value: copyThis ?? value);
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'MembershipDashboardComponentLoaded { value: $value }';
}
