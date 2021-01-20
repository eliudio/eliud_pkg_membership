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
import 'package:eliud_core/tools/query/query_tools.dart';


const _membershipDashboardLimit = 5;

class MembershipDashboardListBloc extends Bloc<MembershipDashboardListEvent, MembershipDashboardListState> {
  final MembershipDashboardRepository _membershipDashboardRepository;
  StreamSubscription _membershipDashboardsListSubscription;
  final EliudQuery eliudQuery;
  int pages = 1;
  final bool paged;
  final String orderBy;
  final bool descending;
  final bool detailed;

  MembershipDashboardListBloc({this.paged, this.orderBy, this.descending, this.detailed, this.eliudQuery, @required MembershipDashboardRepository membershipDashboardRepository})
      : assert(membershipDashboardRepository != null),
        _membershipDashboardRepository = membershipDashboardRepository,
        super(MembershipDashboardListLoading());

  Stream<MembershipDashboardListState> _mapLoadMembershipDashboardListToState() async* {
    int amountNow =  (state is MembershipDashboardListLoaded) ? (state as MembershipDashboardListLoaded).values.length : 0;
    _membershipDashboardsListSubscription?.cancel();
    _membershipDashboardsListSubscription = _membershipDashboardRepository.listen(
          (list) => add(MembershipDashboardListUpdated(value: list, mightHaveMore: amountNow != list.length)),
      orderBy: orderBy,
      descending: descending,
      eliudQuery: eliudQuery,
      limit: ((paged != null) && (paged)) ? pages * _membershipDashboardLimit : null
    );
  }

  Stream<MembershipDashboardListState> _mapLoadMembershipDashboardListWithDetailsToState() async* {
    int amountNow =  (state is MembershipDashboardListLoaded) ? (state as MembershipDashboardListLoaded).values.length : 0;
    _membershipDashboardsListSubscription?.cancel();
    _membershipDashboardsListSubscription = _membershipDashboardRepository.listenWithDetails(
            (list) => add(MembershipDashboardListUpdated(value: list, mightHaveMore: amountNow != list.length)),
        orderBy: orderBy,
        descending: descending,
        eliudQuery: eliudQuery,
        limit: ((paged != null) && (paged)) ? pages * _membershipDashboardLimit : null
    );
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

  Stream<MembershipDashboardListState> _mapMembershipDashboardListUpdatedToState(
      MembershipDashboardListUpdated event) async* {
    yield MembershipDashboardListLoaded(values: event.value, mightHaveMore: event.mightHaveMore);
  }

  @override
  Stream<MembershipDashboardListState> mapEventToState(MembershipDashboardListEvent event) async* {
    if (event is LoadMembershipDashboardList) {
      if ((detailed == null) || (!detailed)) {
        yield* _mapLoadMembershipDashboardListToState();
      } else {
        yield* _mapLoadMembershipDashboardListWithDetailsToState();
      }
    }
    if (event is NewPage) {
      pages = pages + 1; // it doesn't matter so much if we increase pages beyond the end
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


