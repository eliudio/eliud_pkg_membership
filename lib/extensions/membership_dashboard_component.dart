import 'package:eliud_core/access/access_bloc.dart';
import 'package:eliud_core/access/state/access_determined.dart';
import 'package:eliud_core/access/state/access_state.dart';
import 'package:eliud_core_helpers/query/query_tools.dart';
import 'package:eliud_core_main/model/abstract_repository_singleton.dart';
import 'package:eliud_core_main/model/member_public_info_list.dart';
import 'package:eliud_core_main/model/member_public_info_list_bloc.dart';
import 'package:eliud_core_main/model/member_public_info_list_event.dart';
import 'package:eliud_core_main/model/member_public_info_model.dart';
import 'package:eliud_core_main/widgets/alert_widget.dart';
import 'package:eliud_core_main/model/app_model.dart';
import 'package:eliud_core_main/model/background_model.dart';
import 'package:eliud_core_main/apis/style/frontend/has_container.dart';
import 'package:eliud_core_main/apis/style/frontend/has_progress_indicator.dart';
import 'package:eliud_core_main/apis/registryapi/component/component_constructor.dart';
import 'package:eliud_pkg_membership/extensions/widgets/membership_dashboard_item.dart';
import 'package:eliud_pkg_membership_model/model/abstract_repository_singleton.dart';
import 'package:eliud_pkg_membership_model/model/membership_dashboard_component.dart';
import 'package:eliud_pkg_membership_model/model/membership_dashboard_model.dart';
import 'package:eliud_pkg_membership_model/model/membership_dashboard_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MembershipDashboardComponentConstructorDefault
    implements ComponentConstructor {
  @override
  Widget createNew(
      {Key? key,
      required AppModel app,
      required String id,
      Map<String, dynamic>? parameters}) {
    return MembershipDashboard(key: key, app: app, id: id);
  }

  @override
  Future<dynamic> getModel({required AppModel app, required String id}) async =>
      await membershipDashboardRepository(appId: app.documentID)!.get(id);
}

class MembershipDashboard extends AbstractMembershipDashboardComponent {
  MembershipDashboard({super.key, required super.app, required String id})
      : super(membershipDashboardId: id);

  Widget alertWidget({title = String, content = String}) {
    return AlertWidget(app: app, title: title, content: content);
  }

  static EliudQuery getSubscribedMembers(String appId) {
    return EliudQuery(theConditions: [
      EliudQueryCondition('subscriptionsAsStrArr', arrayContains: appId),
    ]);
  }

  @override
  Widget yourWidget(BuildContext context, MembershipDashboardModel? value) {
    return BlocBuilder<AccessBloc, AccessState>(
        builder: (context, accessState) {
      if (accessState is AccessDetermined) {
        var appId = app.documentID;
        return topicContainer(app, context, children: [
          BlocProvider<MemberPublicInfoListBloc>(
            create: (context) => MemberPublicInfoListBloc(
              eliudQuery: getSubscribedMembers(appId),
              memberPublicInfoRepository:
                  memberPublicInfoRepository(appId: appId)!,
            )..add(LoadMemberPublicInfoList()),
            child: simpleTopicContainer(app, context, children: [
              MemberPublicInfoListWidget(
                  app: app,
                  readOnly: true,
                  widgetProvider: (v) => widgetProvider(app, v, value!),
                  listBackground: BackgroundModel())
            ]),
          )
        ]);
      } else {
        return progressIndicator(app, context);
      }
    });
  }

  Widget widgetProvider(AppModel app, MemberPublicInfoModel? value,
      MembershipDashboardModel dashboardModel) {
    return MembershipDashboardItem(
        app: app, value: value, dashboardModel: dashboardModel);
  }

  MembershipDashboardRepository getMembershipDashboardRepository(
      BuildContext context) {
    return membershipDashboardRepository(appId: app.documentID)!;
  }
}
