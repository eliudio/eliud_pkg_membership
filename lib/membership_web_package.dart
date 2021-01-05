import 'membership_package.dart';
import 'model/abstract_repository_singleton.dart';
import 'model/js_repository_singleton.dart';

class MembershipWebPackage extends MembershipPackage {
  @override
  void init() {
    AbstractRepositorySingleton.singleton = JsRepositorySingleton();
    super.init();
  }
}
