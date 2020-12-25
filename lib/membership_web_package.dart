import 'membership_package.dart';

class MembershipWebPackage extends MembershipPackage {
  @override
  void init() {
    // AbstractRepositorySingleton.singleton = JsRepositorySingleton();
    super.init();
  }
}
