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
import 'package:eliud_core/core/access/bloc/access_bloc.dart';
import 'package:eliud_core/core/access/bloc/access_event.dart';
import 'package:eliud_core/tools/query/query_tools.dart';
import 'package:eliud_core/core/access/bloc/access_state.dart';


class MemberPublicInfoListBloc extends Bloc<MemberPublicInfoListEvent, MemberPublicInfoListState> {
  final MemberPublicInfoRepository _memberPublicInfoRepository;
  StreamSubscription _memberPublicInfosListSubscription;
  final AccessBloc accessBloc;
  final EliudQuery eliudQuery;


  MemberPublicInfoListBloc(this.accessBloc,{ this.eliudQuery, @required MemberPublicInfoRepository memberPublicInfoRepository })
      : assert(memberPublicInfoRepository != null),
      _memberPublicInfoRepository = memberPublicInfoRepository,
      super(MemberPublicInfoListLoading());

  Stream<MemberPublicInfoListState> _mapLoadMemberPublicInfoListToState({ String orderBy, bool descending }) async* {
    _memberPublicInfosListSubscription?.cancel();
    _memberPublicInfosListSubscription = _memberPublicInfoRepository.listen((list) => add(MemberPublicInfoListUpdated(value: list)), orderBy: orderBy, descending: descending, eliudQuery: eliudQuery, );
  }

  Stream<MemberPublicInfoListState> _mapLoadMemberPublicInfoListWithDetailsToState() async* {
    _memberPublicInfosListSubscription?.cancel();
    _memberPublicInfosListSubscription = _memberPublicInfoRepository.listenWithDetails((list) => add(MemberPublicInfoListUpdated(value: list)), );
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

  Stream<MemberPublicInfoListState> _mapMemberPublicInfoListUpdatedToState(MemberPublicInfoListUpdated event) async* {
    yield MemberPublicInfoListLoaded(values: event.value);
  }


  @override
  Stream<MemberPublicInfoListState> mapEventToState(MemberPublicInfoListEvent event) async* {
    final currentState = state;
    if (event is LoadMemberPublicInfoList) {
      yield* _mapLoadMemberPublicInfoListToState(orderBy: event.orderBy, descending: event.descending);
    } if (event is LoadMemberPublicInfoListWithDetails) {
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


