import 'membership_package.dart';
import 'model/abstract_repository_singleton.dart';
import 'model/repository_singleton.dart';

class MembershipMobilePackage extends MembershipPackage {

  @override
  List<Object?> get props => [
    stateAccesModel
  ];

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          other is MembershipMobilePackage &&
          runtimeType == other.runtimeType &&
          stateAccesModel == other.stateAccesModel;
}
