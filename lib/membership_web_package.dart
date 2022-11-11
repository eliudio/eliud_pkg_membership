import 'package:flutter/foundation.dart';

import 'membership_package.dart';

MembershipPackage getMembershipPackage() => MembershipWebPackage();

class MembershipWebPackage extends MembershipPackage {

  @override
  List<Object?> get props => [
    stateMEMBER_HAS_NO_MEMBERSHIP_YET
  ];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is MembershipWebPackage &&
              runtimeType == other.runtimeType &&
              mapEquals(stateMEMBER_HAS_NO_MEMBERSHIP_YET, other.stateMEMBER_HAS_NO_MEMBERSHIP_YET);
}
