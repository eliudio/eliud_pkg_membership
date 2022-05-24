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

  void _mapLoadMembershipDashboardComponentUpdateToState(String documentId) {
    _membershipDashboardSubscription?.cancel();
    _membershipDashboardSubscription = membershipDashboardRepository!.listenTo(documentId, (value) {
      if (value != null) {
        add(MembershipDashboardComponentUpdated(value: value));
      }
    });
  }

  MembershipDashboardComponentBloc({ this.membershipDashboardRepository }): super(MembershipDashboardComponentUninitialized()) {
    on <FetchMembershipDashboardComponent> ((event, emit) {
      _mapLoadMembershipDashboardComponentUpdateToState(event.id!);
    });
    on <MembershipDashboardComponentUpdated> ((event, emit) {
      emit(MembershipDashboardComponentLoaded(value: event.value));
    });
  }

  @override
  Future<void> close() {
    _membershipDashboardSubscription?.cancel();
    return super.close();
  }

}

