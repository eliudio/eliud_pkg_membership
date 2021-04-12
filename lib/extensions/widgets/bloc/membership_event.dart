import 'package:eliud_core/model/member_public_info_model.dart';
import 'package:equatable/equatable.dart';

abstract class MembershipEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchMembershipEvent extends MembershipEvent {
  final String? memberId;
  final String? appId;

  FetchMembershipEvent({ this.memberId, this.appId });

  @override
  List<Object> get props => [ memberId!, appId! ];
}

class BlockMember extends MembershipEvent {

  @override
  List<Object> get props => [ ];
}

class PromoteMember extends MembershipEvent {

  @override
  List<Object> get props => [ ];
}

class DemoteMember extends MembershipEvent {

  @override
  List<Object> get props => [ ];
}

class UnblockMember extends MembershipEvent {

  @override
  List<Object> get props => [ ];
}
