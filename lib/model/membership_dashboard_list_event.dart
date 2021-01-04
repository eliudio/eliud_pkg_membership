/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 membership_dashboard_list_event.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:equatable/equatable.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_model.dart';

abstract class MembershipDashboardListEvent extends Equatable {
  const MembershipDashboardListEvent();
  @override
  List<Object> get props => [];
}

class LoadMembershipDashboardList extends MembershipDashboardListEvent {
  final String orderBy;
  final bool descending;

  LoadMembershipDashboardList({this.orderBy, this.descending});

  @override
  List<Object> get props => [orderBy, descending];

}

class LoadMembershipDashboardListWithDetails extends MembershipDashboardListEvent {}

class AddMembershipDashboardList extends MembershipDashboardListEvent {
  final MembershipDashboardModel value;

  const AddMembershipDashboardList({ this.value });

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'AddMembershipDashboardList{ value: $value }';
}

class UpdateMembershipDashboardList extends MembershipDashboardListEvent {
  final MembershipDashboardModel value;

  const UpdateMembershipDashboardList({ this.value });

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'UpdateMembershipDashboardList{ value: $value }';
}

class DeleteMembershipDashboardList extends MembershipDashboardListEvent {
  final MembershipDashboardModel value;

  const DeleteMembershipDashboardList({ this.value });

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'DeleteMembershipDashboardList{ value: $value }';
}

class MembershipDashboardListUpdated extends MembershipDashboardListEvent {
  final List<MembershipDashboardModel> value;

  const MembershipDashboardListUpdated({ this.value });

  @override
  List<Object> get props => [ value ];

  @override
  String toString() => 'MembershipDashboardListUpdated{ value: $value }';
}

