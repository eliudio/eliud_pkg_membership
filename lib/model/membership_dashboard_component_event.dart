/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 membership_dashboard_component_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_model.dart';

abstract class MembershipDashboardComponentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchMembershipDashboardComponent
    extends MembershipDashboardComponentEvent {
  final String? id;

  FetchMembershipDashboardComponent({this.id});
}

class MembershipDashboardComponentUpdated
    extends MembershipDashboardComponentEvent {
  final MembershipDashboardModel value;

  MembershipDashboardComponentUpdated({required this.value});
}
