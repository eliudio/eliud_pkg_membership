import 'package:eliud_core/model/abstract_repository_singleton.dart'
      as corerepo;
import 'package:eliud_core/core/wizards/builders/page_builder.dart';
import 'package:eliud_core/core/wizards/registry/registry.dart';
import 'package:eliud_core/core/wizards/tools/documentIdentifier.dart';
import 'package:eliud_core/model/app_bar_model.dart';
import 'package:eliud_core/model/drawer_model.dart';
import 'package:eliud_core/model/home_menu_model.dart';
import 'package:eliud_core/model/model_export.dart';
import 'package:eliud_core/model/page_model.dart';
import 'package:eliud_pkg_membership/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_component.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_model.dart';
import 'package:eliud_core/core/wizards/builders/single_component_page_builder.dart';

class MembershipDashboardPageBuilder extends SingleComponentPageBuilder {
  MembershipDashboardPageBuilder(
      String uniqueId,
      String pageId,
      AppModel app,
      String memberId,
      HomeMenuModel theHomeMenu,
      AppBarModel theAppBar,
      DrawerModel leftDrawer,
      DrawerModel rightDrawer,
      PageProvider pageProvider,
      )
      : super(uniqueId, pageId, app, memberId, theHomeMenu, theAppBar,
            leftDrawer, rightDrawer, pageProvider, );

  static MembershipDashboardModel _dashboardModel(AppModel app, String uniqueId, String componentIdentifier) {
    return MembershipDashboardModel(
      documentID: constructDocumentId(uniqueId: uniqueId, documentId: componentIdentifier),
      appId: app.documentID!,
      description: "Members",
      memberActions: null,
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
          PrivilegeLevelRequiredSimple.OwnerPrivilegeRequiredSimple),
    );
  }

  static Future<MembershipDashboardModel> setupDashboard(AppModel app, String uniqueId, String componentIdentifier) async {
    return await membershipDashboardRepository(appId: app.documentID!)!
        .add(_dashboardModel(app, uniqueId, componentIdentifier));
  }

  Future<PageModel> run(
      {required String componentIdentifier}) async {
    await setupDashboard(app, uniqueId, componentIdentifier);
    return await doIt(
        componentName: AbstractMembershipDashboardComponent.componentName,
        componentIdentifier: componentIdentifier,
        title: "App members");
  }
}
