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
import 'package:flutter/services.dart';

class MembershipDashboardComponentBloc extends Bloc<MembershipDashboardComponentEvent, MembershipDashboardComponentState> {
  final MembershipDashboardRepository? membershipDashboardRepository;
  StreamSubscription? _membershipDashboardSubscription;

  Stream<MembershipDashboardComponentState> _mapLoadMembershipDashboardComponentUpdateToState(String documentId) async* {
    _membershipDashboardSubscription?.cancel();
    _membershipDashboardSubscription = membershipDashboardRepository!.listenTo(documentId, (value) {
      if (value != null) add(MembershipDashboardComponentUpdated(value: value!));
    });
  }

  MembershipDashboardComponentBloc({ this.membershipDashboardRepository }): super(MembershipDashboardComponentUninitialized());

  @override
  Stream<MembershipDashboardComponentState> mapEventToState(MembershipDashboardComponentEvent event) async* {
    final currentState = state;
    if (event is FetchMembershipDashboardComponent) {
      yield* _mapLoadMembershipDashboardComponentUpdateToState(event.id!);
    } else if (event is MembershipDashboardComponentUpdated) {
      yield MembershipDashboardComponentLoaded(value: event.value);
    }
  }

  @override
  Future<void> close() {
    _membershipDashboardSubscription?.cancel();
    return super.close();
  }

}

