/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 membership_dashboard_component_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:eliud_pkg_membership/model/membership_dashboard_model.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_component_event.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_component_state.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_repository.dart';
class MembershipDashboardComponentBloc extends Bloc<MembershipDashboardComponentEvent, MembershipDashboardComponentState> {
  final MembershipDashboardRepository membershipDashboardRepository;

  MembershipDashboardComponentBloc({ this.membershipDashboardRepository }): super(MembershipDashboardComponentUninitialized());
  @override
  Stream<MembershipDashboardComponentState> mapEventToState(MembershipDashboardComponentEvent event) async* {
    final currentState = state;
    if (event is FetchMembershipDashboardComponent) {
      try {
        if (currentState is MembershipDashboardComponentUninitialized) {
          final MembershipDashboardModel model = await _fetchMembershipDashboard(event.id);

          if (model != null) {
            yield MembershipDashboardComponentLoaded(value: model);
          } else {
            String id = event.id;
            yield MembershipDashboardComponentError(message: "MembershipDashboard with id = '$id' not found");
          }
          return;
        }
      } catch (_) {
        yield MembershipDashboardComponentError(message: "Unknown error whilst retrieving MembershipDashboard");
      }
    }
  }

  Future<MembershipDashboardModel> _fetchMembershipDashboard(String id) async {
    return membershipDashboardRepository.get(id);
  }

  @override
  Future<void> close() {
    return super.close();
  }

}

