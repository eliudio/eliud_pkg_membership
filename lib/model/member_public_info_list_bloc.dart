/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 member_public_info_list_bloc.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:eliud_pkg_membership/model/member_public_info_repository.dart';
import 'package:eliud_pkg_membership/model/member_public_info_list_event.dart';
import 'package:eliud_pkg_membership/model/member_public_info_list_state.dart';
import 'package:eliud_core/tools/query/query_tools.dart';


const _memberPublicInfoLimit = 5;

class MemberPublicInfoListBloc extends Bloc<MemberPublicInfoListEvent, MemberPublicInfoListState> {
  final MemberPublicInfoRepository _memberPublicInfoRepository;
  StreamSubscription _memberPublicInfosListSubscription;
  final EliudQuery eliudQuery;
  int pages = 1;
  final bool paged;
  final String orderBy;
  final bool descending;
  final bool detailed;

  MemberPublicInfoListBloc({this.paged, this.orderBy, this.descending, this.detailed, this.eliudQuery, @required MemberPublicInfoRepository memberPublicInfoRepository})
      : assert(memberPublicInfoRepository != null),
        _memberPublicInfoRepository = memberPublicInfoRepository,
        super(MemberPublicInfoListLoading());

  Stream<MemberPublicInfoListState> _mapLoadMemberPublicInfoListToState() async* {
    int amountNow =  (state is MemberPublicInfoListLoaded) ? (state as MemberPublicInfoListLoaded).values.length : 0;
    _memberPublicInfosListSubscription?.cancel();
    _memberPublicInfosListSubscription = _memberPublicInfoRepository.listen(
          (list) => add(MemberPublicInfoListUpdated(value: list, mightHaveMore: amountNow != list.length)),
      orderBy: orderBy,
      descending: descending,
      eliudQuery: eliudQuery,
      limit: ((paged != null) && (paged)) ? pages * _memberPublicInfoLimit : null
    );
  }

  Stream<MemberPublicInfoListState> _mapLoadMemberPublicInfoListWithDetailsToState() async* {
    int amountNow =  (state is MemberPublicInfoListLoaded) ? (state as MemberPublicInfoListLoaded).values.length : 0;
    _memberPublicInfosListSubscription?.cancel();
    _memberPublicInfosListSubscription = _memberPublicInfoRepository.listenWithDetails(
            (list) => add(MemberPublicInfoListUpdated(value: list, mightHaveMore: amountNow != list.length)),
        orderBy: orderBy,
        descending: descending,
        eliudQuery: eliudQuery,
        limit: ((paged != null) && (paged)) ? pages * _memberPublicInfoLimit : null
    );
  }

  Stream<MemberPublicInfoListState> _mapAddMemberPublicInfoListToState(AddMemberPublicInfoList event) async* {
    _memberPublicInfoRepository.add(event.value);
  }

  Stream<MemberPublicInfoListState> _mapUpdateMemberPublicInfoListToState(UpdateMemberPublicInfoList event) async* {
    _memberPublicInfoRepository.update(event.value);
  }

  Stream<MemberPublicInfoListState> _mapDeleteMemberPublicInfoListToState(DeleteMemberPublicInfoList event) async* {
    _memberPublicInfoRepository.delete(event.value);
  }

  Stream<MemberPublicInfoListState> _mapMemberPublicInfoListUpdatedToState(
      MemberPublicInfoListUpdated event) async* {
    yield MemberPublicInfoListLoaded(values: event.value, mightHaveMore: event.mightHaveMore);
  }

  @override
  Stream<MemberPublicInfoListState> mapEventToState(MemberPublicInfoListEvent event) async* {
    if (event is LoadMemberPublicInfoList) {
      if ((detailed == null) || (!detailed)) {
        yield* _mapLoadMemberPublicInfoListToState();
      } else {
        yield* _mapLoadMemberPublicInfoListWithDetailsToState();
      }
    }
    if (event is NewPage) {
      pages = pages + 1; // it doesn't matter so much if we increase pages beyond the end
      yield* _mapLoadMemberPublicInfoListWithDetailsToState();
    } else if (event is AddMemberPublicInfoList) {
      yield* _mapAddMemberPublicInfoListToState(event);
    } else if (event is UpdateMemberPublicInfoList) {
      yield* _mapUpdateMemberPublicInfoListToState(event);
    } else if (event is DeleteMemberPublicInfoList) {
      yield* _mapDeleteMemberPublicInfoListToState(event);
    } else if (event is MemberPublicInfoListUpdated) {
      yield* _mapMemberPublicInfoListUpdatedToState(event);
    }
  }

  @override
  Future<void> close() {
    _memberPublicInfosListSubscription?.cancel();
    return super.close();
  }
}


