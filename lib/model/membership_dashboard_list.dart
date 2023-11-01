/*
       _ _           _ 
      | (_)         | |
   ___| |_ _   _  __| |
  / _ \ | | | | |/ _` |
 |  __/ | | |_| | (_| |
  \___|_|_|\__,_|\__,_|
                       
 
 membership_dashboard_list.dart
                       
 This code is generated. This is read only. Don't touch!

*/

import 'package:eliud_core/core/blocs/access/access_bloc.dart';
import 'package:eliud_core/core/blocs/access/state/access_state.dart';
import 'package:eliud_core/core/blocs/access/state/access_determined.dart';
import 'package:eliud_core/style/style_registry.dart';
import 'package:eliud_core/tools/has_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eliud_core/model/background_model.dart';
import 'package:eliud_core/tools/delete_snackbar.dart';
import 'package:eliud_core/tools/router_builders.dart';
import 'package:eliud_core/tools/etc.dart';
import 'package:eliud_core/tools/enums.dart';
import 'package:eliud_core/style/frontend/has_text.dart';

import 'package:eliud_pkg_membership/model/membership_dashboard_list_event.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_list_state.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_list_bloc.dart';
import 'package:eliud_pkg_membership/model/membership_dashboard_model.dart';

import 'package:eliud_core/model/app_model.dart';


import 'membership_dashboard_form.dart';


typedef MembershipDashboardWidgetProvider(MembershipDashboardModel? value);

class MembershipDashboardListWidget extends StatefulWidget with HasFab {
  AppModel app;
  BackgroundModel? listBackground;
  MembershipDashboardWidgetProvider? widgetProvider;
  bool? readOnly;
  String? form;
  MembershipDashboardListWidgetState? state;
  bool? isEmbedded;

  MembershipDashboardListWidget({ Key? key, required this.app, this.readOnly, this.form, this.widgetProvider, this.isEmbedded, this.listBackground }): super(key: key);

  @override
  MembershipDashboardListWidgetState createState() {
    state ??= MembershipDashboardListWidgetState();
    return state!;
  }

  @override
  Widget? fab(BuildContext context) {
    if ((readOnly != null) && readOnly!) return null;
    state ??= MembershipDashboardListWidgetState();
    var accessState = AccessBloc.getState(context);
    return state!.fab(context, accessState);
  }
}

class MembershipDashboardListWidgetState extends State<MembershipDashboardListWidget> {
  @override
  Widget? fab(BuildContext aContext, AccessState accessState) {
    return !accessState.memberIsOwner(widget.app.documentID) 
      ? null
      : StyleRegistry.registry().styleWithApp(widget.app).adminListStyle().floatingActionButton(widget.app, context, 'PageFloatBtnTag', Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).push(
          pageRouteBuilder(widget.app, page: BlocProvider.value(
              value: BlocProvider.of<MembershipDashboardListBloc>(context),
              child: MembershipDashboardForm(app:widget.app,
                  value: null,
                  formAction: FormAction.AddAction)
          )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccessBloc, AccessState>(
        builder: (context, accessState) {
      if (accessState is AccessDetermined) {
        return BlocBuilder<MembershipDashboardListBloc, MembershipDashboardListState>(builder: (context, state) {
          if (state is MembershipDashboardListLoading) {
            return StyleRegistry.registry().styleWithApp(widget.app).adminListStyle().progressIndicator(widget.app, context);
          } else if (state is MembershipDashboardListLoaded) {
            final values = state.values;
            if ((widget.isEmbedded != null) && widget.isEmbedded!) {
              var children = <Widget>[];
              children.add(theList(context, values, accessState));
              children.add(
                  StyleRegistry.registry().styleWithApp(widget.app).adminFormStyle().button(widget.app,
                      context, label: 'Add',
                      onPressed: () {
                        Navigator.of(context).push(
                                  pageRouteBuilder(widget.app, page: BlocProvider.value(
                                      value: BlocProvider.of<MembershipDashboardListBloc>(context),
                                      child: MembershipDashboardForm(app:widget.app,
                                          value: null,
                                          formAction: FormAction.AddAction)
                                  )),
                                );
                      },
                    ));
              return ListView(
                padding: const EdgeInsets.all(8),
                physics: ScrollPhysics(),
                shrinkWrap: true,
                children: children
              );
            } else {
              return theList(context, values, accessState);
            }
          } else {
            return StyleRegistry.registry().styleWithApp(widget.app).adminListStyle().progressIndicator(widget.app, context);
          }
        });
      } else {
        return StyleRegistry.registry().styleWithApp(widget.app).adminListStyle().progressIndicator(widget.app, context);
      }
    });
  }
  
  Widget theList(BuildContext context, values, AccessState accessState) {
    return Container(
      decoration: widget.listBackground == null ? StyleRegistry.registry().styleWithApp(widget.app).adminListStyle().boxDecorator(widget.app, context, accessState.getMember()) : BoxDecorationHelper.boxDecoration(widget.app, accessState.getMember(), widget.listBackground),
      child: ListView.separated(
        separatorBuilder: (context, index) => StyleRegistry.registry().styleWithApp(widget.app).adminListStyle().divider(widget.app, context),
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: values.length,
        itemBuilder: (context, index) {
          final value = values[index];
          
          if (widget.widgetProvider != null) return widget.widgetProvider!(value);

          return MembershipDashboardListItem(app: widget.app,
            value: value,
//            app: accessState.app,
            onDismissed: (direction) {
              BlocProvider.of<MembershipDashboardListBloc>(context)
                  .add(DeleteMembershipDashboardList(value: value));
              ScaffoldMessenger.of(context).showSnackBar(DeleteSnackBar(
                message: "MembershipDashboard " + value.documentID,
                onUndo: () => BlocProvider.of<MembershipDashboardListBloc>(context)
                    .add(AddMembershipDashboardList(value: value)),
              ));
            },
            onTap: () async {
                                   final removedItem = await Navigator.of(context).push(
                        pageRouteBuilder(widget.app, page: BlocProvider.value(
                              value: BlocProvider.of<MembershipDashboardListBloc>(context),
                              child: getForm(value, FormAction.UpdateAction))));
                      if (removedItem != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          DeleteSnackBar(
                        message: "MembershipDashboard " + value.documentID,
                            onUndo: () => BlocProvider.of<MembershipDashboardListBloc>(context)
                                .add(AddMembershipDashboardList(value: value)),
                          ),
                        );
                      }

            },
          );
        }
      ));
  }
  
  
  Widget? getForm(value, action) {
    if (widget.form == null) {
      return MembershipDashboardForm(app:widget.app, value: value, formAction: action);
    } else {
      return null;
    }
  }
  
  
}


class MembershipDashboardListItem extends StatelessWidget {
  final AppModel app;
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final MembershipDashboardModel value;

  MembershipDashboardListItem({
    Key? key,
    required this.app,
    required this.onDismissed,
    required this.onTap,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('__MembershipDashboard_item_${value.documentID}'),
      onDismissed: onDismissed,
      child: ListTile(
        onTap: onTap,
        title: value.description != null ? Center(child: text(app, context, value.description!)) : value.documentID != null ? Center(child: text(app, context, value.documentID)) : Container(),
      ),
    );
  }
}

