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

/*
 * MembershipDashboardComponentEvent is the base class for events to be used with constructing a MembershipDashboardComponentBloc 
 */
abstract class MembershipDashboardComponentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

/*
 * FetchMembershipDashboardComponent is the event to instruct the bloc to fetch the component
 */
class FetchMembershipDashboardComponent
    extends MembershipDashboardComponentEvent {
  final String? id;

  /*
   * Construct the FetchMembershipDashboardComponent
   */
  FetchMembershipDashboardComponent({this.id});
}

/*
 * MembershipDashboardComponentUpdated is the event to inform the bloc that a component has been updated
 */
class MembershipDashboardComponentUpdated
    extends MembershipDashboardComponentEvent {
  final MembershipDashboardModel value;

  /*
   * Construct the MembershipDashboardComponentUpdated
   */
  MembershipDashboardComponentUpdated({required this.value});
}
