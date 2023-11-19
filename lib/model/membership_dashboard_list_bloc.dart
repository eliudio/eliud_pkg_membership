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

import 'package:eliud_pkg_membership/model/membership_dashboard_repository.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_list_event.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_list_state.dart';
import 'package:eliud_core_model/tools/query/query_tools.dart';

import 'membership_dashboard_model.dart';

typedef FilterMembershipDashboardModels = List<MembershipDashboardModel?>
    Function(List<MembershipDashboardModel?> values);

class MembershipDashboardListBloc
    extends Bloc<MembershipDashboardListEvent, MembershipDashboardListState> {
  final FilterMembershipDashboardModels? filter;
  final MembershipDashboardRepository _membershipDashboardRepository;
  StreamSubscription? _membershipDashboardsListSubscription;
  EliudQuery? eliudQuery;
  int pages = 1;
  final bool? paged;
  final String? orderBy;
  final bool? descending;
  final bool? detailed;
  final int membershipDashboardLimit;

  MembershipDashboardListBloc(
      {this.filter,
      this.paged,
      this.orderBy,
      this.descending,
      this.detailed,
      this.eliudQuery,
      required MembershipDashboardRepository membershipDashboardRepository,
      this.membershipDashboardLimit = 5})
      : _membershipDashboardRepository = membershipDashboardRepository,
        super(MembershipDashboardListLoading()) {
    on<LoadMembershipDashboardList>((event, emit) {
      if ((detailed == null) || (!detailed!)) {
        _mapLoadMembershipDashboardListToState();
      } else {
        _mapLoadMembershipDashboardListWithDetailsToState();
      }
    });

    on<NewPage>((event, emit) {
      pages = pages +
          1; // it doesn't matter so much if we increase pages beyond the end
      _mapLoadMembershipDashboardListWithDetailsToState();
    });

    on<MembershipDashboardChangeQuery>((event, emit) {
      eliudQuery = event.newQuery;
      if ((detailed == null) || (!detailed!)) {
        _mapLoadMembershipDashboardListToState();
      } else {
        _mapLoadMembershipDashboardListWithDetailsToState();
      }
    });

    on<AddMembershipDashboardList>((event, emit) async {
      await _mapAddMembershipDashboardListToState(event);
    });

    on<UpdateMembershipDashboardList>((event, emit) async {
      await _mapUpdateMembershipDashboardListToState(event);
    });

    on<DeleteMembershipDashboardList>((event, emit) async {
      await _mapDeleteMembershipDashboardListToState(event);
    });

    on<MembershipDashboardListUpdated>((event, emit) {
      emit(_mapMembershipDashboardListUpdatedToState(event));
    });
  }

  List<MembershipDashboardModel?> _filter(
      List<MembershipDashboardModel?> original) {
    if (filter != null) {
      return filter!(original);
    } else {
      return original;
    }
  }

  Future<void> _mapLoadMembershipDashboardListToState() async {
    int amountNow = (state is MembershipDashboardListLoaded)
        ? (state as MembershipDashboardListLoaded).values!.length
        : 0;
    _membershipDashboardsListSubscription?.cancel();
    _membershipDashboardsListSubscription =
        _membershipDashboardRepository.listen(
            (list) => add(MembershipDashboardListUpdated(
                value: _filter(list), mightHaveMore: amountNow != list.length)),
            orderBy: orderBy,
            descending: descending,
            eliudQuery: eliudQuery,
            limit: ((paged != null) && paged!)
                ? pages * membershipDashboardLimit
                : null);
  }

  Future<void> _mapLoadMembershipDashboardListWithDetailsToState() async {
    int amountNow = (state is MembershipDashboardListLoaded)
        ? (state as MembershipDashboardListLoaded).values!.length
        : 0;
    _membershipDashboardsListSubscription?.cancel();
    _membershipDashboardsListSubscription =
        _membershipDashboardRepository.listenWithDetails(
            (list) => add(MembershipDashboardListUpdated(
                value: _filter(list), mightHaveMore: amountNow != list.length)),
            orderBy: orderBy,
            descending: descending,
            eliudQuery: eliudQuery,
            limit: ((paged != null) && paged!)
                ? pages * membershipDashboardLimit
                : null);
  }

  Future<void> _mapAddMembershipDashboardListToState(
      AddMembershipDashboardList event) async {
    var value = event.value;
    if (value != null) {
      await _membershipDashboardRepository.add(value);
    }
  }

  Future<void> _mapUpdateMembershipDashboardListToState(
      UpdateMembershipDashboardList event) async {
    var value = event.value;
    if (value != null) {
      await _membershipDashboardRepository.update(value);
    }
  }

  Future<void> _mapDeleteMembershipDashboardListToState(
      DeleteMembershipDashboardList event) async {
    var value = event.value;
    if (value != null) {
      await _membershipDashboardRepository.delete(value);
    }
  }

  MembershipDashboardListLoaded _mapMembershipDashboardListUpdatedToState(
          MembershipDashboardListUpdated event) =>
      MembershipDashboardListLoaded(
          values: event.value, mightHaveMore: event.mightHaveMore);

  @override
  Future<void> close() {
    _membershipDashboardsListSubscription?.cancel();
    return super.close();
  }
}
