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

/* 
 * MembershipDashboardComponentState is the base class for state for MembershipDashboardComponentBloc
 */
abstract class MembershipDashboardComponentState extends Equatable {
  const MembershipDashboardComponentState();

  @override
  List<Object?> get props => [];
}

/* 
 * MembershipDashboardComponentUninitialized is the uninitialized state of the MembershipDashboardComponentBloc 
 */
class MembershipDashboardComponentUninitialized
    extends MembershipDashboardComponentState {}

/* 
 * MembershipDashboardComponentError is the error state of the MembershipDashboardComponentBloc 
 */
class MembershipDashboardComponentError
    extends MembershipDashboardComponentState {
  final String? message;
  MembershipDashboardComponentError({this.message});
}

/* 
 * MembershipDashboardComponentPermissionDenied is to indicate permission denied state of the MembershipDashboardComponentBloc 
 */
class MembershipDashboardComponentPermissionDenied
    extends MembershipDashboardComponentState {
  MembershipDashboardComponentPermissionDenied();
}

/* 
 * MembershipDashboardComponentLoaded is used to set the state of the MembershipDashboardComponentBloc to the loaded state
 */
class MembershipDashboardComponentLoaded
    extends MembershipDashboardComponentState {
  final MembershipDashboardModel value;

  /* 
   * construct MembershipDashboardComponentLoaded
   */
  const MembershipDashboardComponentLoaded({required this.value});

  /* 
   * copy method
   */
  MembershipDashboardComponentLoaded copyWith(
      {MembershipDashboardModel? copyThis}) {
    return MembershipDashboardComponentLoaded(value: copyThis ?? value);
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => 'MembershipDashboardComponentLoaded { value: $value }';
}
