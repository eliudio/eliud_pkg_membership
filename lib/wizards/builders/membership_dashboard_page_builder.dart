import 'package:eliud_core_main/model/app_model.dart';
import 'package:eliud_core_main/model/page_model.dart';
import 'package:eliud_core_main/model/storage_conditions_model.dart';
import 'package:eliud_core_main/wizards/tools/document_identifier.dart';
import 'package:eliud_pkg_membership_model/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_membership_model/model/membership_dashboard_component.dart';
import 'package:eliud_pkg_membership_model/model/membership_dashboard_model.dart';
import 'package:eliud_core_main/wizards/builders/single_component_page_builder.dart';

class MembershipDashboardPageBuilder extends SingleComponentPageBuilder {
  MembershipDashboardPageBuilder(
    super.uniqueId,
    super.pageId,
    super.app,
    super.memberId,
    super.theHomeMenu,
    super.theAppBar,
    super.leftDrawer,
    super.rightDrawer,
  );

  static MembershipDashboardModel _dashboardModel(
      AppModel app, String uniqueId, String componentIdentifier) {
    return MembershipDashboardModel(
      documentID: constructDocumentId(
          uniqueId: uniqueId, documentId: componentIdentifier),
      appId: app.documentID,
      description: 'Membership dashboard',
      memberActions: null,
      conditions: StorageConditionsModel(
          privilegeLevelRequired:
              PrivilegeLevelRequiredSimple.ownerPrivilegeRequiredSimple),
    );
  }

  static Future<MembershipDashboardModel> setupDashboard(
      AppModel app, String uniqueId, String componentIdentifier) async {
    return await membershipDashboardRepository(appId: app.documentID)!
        .add(_dashboardModel(app, uniqueId, componentIdentifier));
  }

  Future<PageModel> run({required String componentIdentifier}) async {
    await setupDashboard(app, uniqueId, componentIdentifier);
    return await doIt(
        componentName: AbstractMembershipDashboardComponent.componentName,
        componentIdentifier: componentIdentifier,
        title: "App members",
        description: 'App members"');
  }
}
