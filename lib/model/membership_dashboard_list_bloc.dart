/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 membership_dashboard_list_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:eliud_pkg_membership/model/membership_dashboard_repository.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_list_event.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_list_state.dart';
import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_event.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';


class MembershipDashboardListBloc extends Bloc<MembershipDashboardListEvent, MembershipDashboardListState> {
  final MembershipDashboardRepository _membershipDashboardRepository;
  StreamSubscription _membershipDashboardsListSubscription;
  final AccessBloc accessBloc;
  final EliudQuery eliudQuery;


  MembershipDashboardListBloc(this.accessBloc,{ this.eliudQuery, @required MembershipDashboardRepository membershipDashboardRepository })
      : assert(membershipDashboardRepository != null),
      _membershipDashboardRepository = membershipDashboardRepository,
      super(MembershipDashboardListLoading());

  Stream<MembershipDashboardListState> _mapLoadMembershipDashboardListToState({ String orderBy, bool descending }) async* {
    _membershipDashboardsListSubscription?.cancel();
    _membershipDashboardsListSubscription = _membershipDashboardRepository.listen((list) => add(MembershipDashboardListUpdated(value: list)), orderBy: orderBy, descending: descending, eliudQuery: eliudQuery, );
  }

  Stream<MembershipDashboardListState> _mapLoadMembershipDashboardListWithDetailsToState() async* {
    _membershipDashboardsListSubscription?.cancel();
    _membershipDashboardsListSubscription = _membershipDashboardRepository.listenWithDetails((list) => add(MembershipDashboardListUpdated(value: list)), );
  }

  Stream<MembershipDashboardListState> _mapAddMembershipDashboardListToState(AddMembershipDashboardList event) async* {
    _membershipDashboardRepository.add(event.value);
  }

  Stream<MembershipDashboardListState> _mapUpdateMembershipDashboardListToState(UpdateMembershipDashboardList event) async* {
    _membershipDashboardRepository.update(event.value);
  }

  Stream<MembershipDashboardListState> _mapDeleteMembershipDashboardListToState(DeleteMembershipDashboardList event) async* {
    _membershipDashboardRepository.delete(event.value);
  }

  Stream<MembershipDashboardListState> _mapMembershipDashboardListUpdatedToState(MembershipDashboardListUpdated event) async* {
    yield MembershipDashboardListLoaded(values: event.value);
  }


  @override
  Stream<MembershipDashboardListState> mapEventToState(MembershipDashboardListEvent event) async* {
    final currentState = state;
    if (event is LoadMembershipDashboardList) {
      yield* _mapLoadMembershipDashboardListToState(orderBy: event.orderBy, descending: event.descending);
    } if (event is LoadMembershipDashboardListWithDetails) {
      yield* _mapLoadMembershipDashboardListWithDetailsToState();
    } else if (event is AddMembershipDashboardList) {
      yield* _mapAddMembershipDashboardListToState(event);
    } else if (event is UpdateMembershipDashboardList) {
      yield* _mapUpdateMembershipDashboardListToState(event);
    } else if (event is DeleteMembershipDashboardList) {
      yield* _mapDeleteMembershipDashboardListToState(event);
    } else if (event is MembershipDashboardListUpdated) {
      yield* _mapMembershipDashboardListUpdatedToState(event);
    }
  }

  @override
  Future<void> close() {
    _membershipDashboardsListSubscription?.cancel();
    return super.close();
  }

}


