import 'package:eliud_core/model/access_model.dart';
import 'package:eliud_core/model/member_public_info_model.dart';
import 'package:equatable/equatable.dart';
import 'package:eliud_core/model/app_bar_model.dart';

abstract class MembershipState extends Equatable {
  const MembershipState();

  @override
  List<Object> get props => [];
}

class UnitializedMembership extends MembershipState {
}

class MembershipLoaded extends MembershipState {
  final AccessModel? accessModel;
  final String? appId;
  final MemberPublicInfoModel? member;

  MembershipLoaded(this.accessModel, this.appId, this.member);

  @override
  List<Object> get props => [ accessModel!, appId!, member!];
}
