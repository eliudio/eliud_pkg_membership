import 'membership_package.dart';
import 'model/abstract_repository_singleton.dart';
import 'model/repository_singleton.dart';

class MembershipMobilePackage extends MembershipPackage {
  @override
  void init() {
    AbstractRepositorySingleton.singleton = RepositorySingleton();
    super.init();
  }
}
