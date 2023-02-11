import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notify/bloc/app_bloc.dart';
import 'package:notify/utils/colors.dart';
import 'package:notify/utils/layout.dart';
import 'package:notify/utils/time.dart';

class RedmineIssuesList extends StatelessWidget {
  const RedmineIssuesList({super.key});

  Future<bool> onRefresh(BuildContext ctx) async {
    BlocProvider.of<AppBloc>(ctx).onGetMyIssue(true);
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: RefreshIndicator(
            onRefresh: () {
              return onRefresh.call(context);
            },
            child: BlocBuilder<AppBloc, AppState>(
              builder: (context, state) {
                final selectedIssue = state.selectedIssuesId;
                return ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(height: AppLayout.getHeight(context, 20));
                  },
                  itemCount: state.issues.length,
                  itemBuilder: (context, index) {
                    final issue = state.issues[index];
                    final dueInDays =
                        DateParser.dueDateInDays(issue.dueDate ?? '');
                    final dueText = dueInDays > 0
                        ? "In next $dueInDays"
                        : "Due for ${dueInDays * -1}";

                    final isIssueSelected = selectedIssue == index;
                    return InkWell(
                      onTap: () {
                        context.read<AppBloc>().onIssueSelected(index);
                      },
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: (dueInDays > 0)
                                      ? AppColor.greenColor
                                      : AppColor.erroBorder,
                                  border: Border.all(
                                    color: Colors.black38,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                                child: Text("$dueText days",
                                    style: TextStyle(
                                      color: AppColor.issueDueTextColor
                                          .withOpacity(0.8),
                                      fontWeight: FontWeight.w500,
                                    )),
                              ),
                              RichText(
                                  text: TextSpan(
                                      text: "Due date\t:",
                                      style: TextStyle(
                                        color: AppColor.inputHintColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      children: [
                                    TextSpan(
                                        text: "\t${issue.dueDate}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ))
                                  ])),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: !isIssueSelected
                                  ? Colors.transparent
                                  : AppColor.btnBg,
                              border: Border.all(
                                  color: AppColor.white.withOpacity(0.1),
                                  width: 1),
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: AppColor.white
                                                  .withOpacity(0.1),
                                              width: 1))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                            child: Text(
                                          'Issue No:- ${issue.id}',
                                          maxLines: 1,
                                          style: TextStyle(
                                            color:
                                                AppColor.white.withOpacity(0.8),
                                            fontSize: 14,
                                          ),
                                        )),
                                        Text(
                                          '${issue.subject}',
                                          style: TextStyle(
                                            color:
                                                AppColor.white.withOpacity(0.8),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    '${issue.description}',
                                    style: TextStyle(
                                      color: AppColor.inputHintColor
                                          .withOpacity(0.8),
                                      fontSize: 14,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ));
  }
}
