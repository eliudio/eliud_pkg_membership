import 'package:eliud_core_model/model/app_model.dart';
import 'package:equatable/equatable.dart';

abstract class MembershipEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchMembershipEvent extends MembershipEvent {
  final String memberId;
  final AppModel app;

  FetchMembershipEvent({required this.memberId, required this.app});

  @override
  List<Object> get props => [memberId, app];
}

class BlockMember extends MembershipEvent {
  @override
  List<Object> get props => [];
}

class PromoteMember extends MembershipEvent {
  @override
  List<Object> get props => [];
}

class DemoteMember extends MembershipEvent {
  @override
  List<Object> get props => [];
}

class UnblockMember extends MembershipEvent {
  @override
  List<Object> get props => [];
}
