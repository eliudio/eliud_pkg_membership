import 'package:flutter/foundation.dart';

import 'membership_package.dart';

MembershipPackage getMembershipPackage() => MembershipWebPackage();

class MembershipWebPackage extends MembershipPackage {
  @override
  List<Object?> get props => [stateMemberHasNoMembershipYet];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MembershipWebPackage &&
          runtimeType == other.runtimeType &&
          mapEquals(stateMemberHasNoMembershipYet,
              other.stateMemberHasNoMembershipYet);

  @override
  int get hashCode => stateMemberHasNoMembershipYet.hashCode;
}
