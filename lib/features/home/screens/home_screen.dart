import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:thoughts/features/auth/services/auth_service.dart';
import 'package:thoughts/features/home/providers/notes_provider.dart';
import 'package:thoughts/global_widgets/custom_shimmer.dart';
import 'package:thoughts/utils/routes/app_route_constant.dart';
import 'package:thoughts/utils/themes/themes.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final journalData = ref.watch(journalProvider);
    return Scaffold(
      backgroundColor: AppColors.brandWhite,
      appBar: AppBar(
        backgroundColor: AppColors.brandWhite,
        leading: Builder(builder: (context) {
          return GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        backgroundColor: AppColors.brandWhite,
                        iconColor: AppColors.warningRed,
                        alignment: Alignment.center,
                        surfaceTintColor: AppColors.brandWhite,
                        actionsAlignment: MainAxisAlignment.center,
                        title: const Text(
                          'Are you sure you want to logout?',
                          style: TT.f16w700,
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          TextButton.icon(
                              onPressed: () async {
                                await AuthService().signOut();
                                if (context.mounted) {
                                  context.pop();
                                  context.goNamed(AppRouteConstant.loginScreen);
                                }
                              },
                              icon: const Icon(
                                Icons.logout_rounded,
                                color: AppColors.warningRed,
                              ),
                              label: Text(
                                'Logout',
                                style: TT.f16w800
                                    .copyWith(color: AppColors.warningRed),
                              ))
                        ],
                      ));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(color: AppColors.borderGreyColor),
                  borderRadius: BorderRadius.circular(12)),
              child: const Icon(
                Icons.more_horiz_rounded,
                color: AppColors.brandBlack,
              ),
            ),
          );
        }),
        title: const Text('THOUGHTS'),
      ),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: AppColors.brandBlack,
        onPressed: () {
          context.pushNamed(AppRouteConstant.noteScreen,
              extra: {'updateNote': false});
        },
        child: const Icon(
          Icons.add,
          color: AppColors.brandWhite,
        ),
      ),
      body: SafeArea(
          child: journalData.when(
        data: (data) {
          if (data.isEmpty) {
            return const Center(child: Text('Add your first thought!'));
          } else {
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  DateTime date = DateTime.parse(data[index]['created_at'] ??
                      DateTime.now().toIso8601String());
                  return Slidable(
                    closeOnScroll: true,
                    endActionPane:
                        ActionPane(motion: const ScrollMotion(), children: [
                      SlidableAction(
                        flex: 1,
                        label: 'Delete',
                        onPressed: ((context) {}),
                        backgroundColor: AppColors.warningRed,
                        icon: Icons.delete,
                      )
                    ]),
                    child: ListTile(
                      isThreeLine: false,
                      dense: true,
                      titleAlignment: ListTileTitleAlignment.top,
                      onTap: () {
                        context.pushNamed(AppRouteConstant.noteScreen, extra: {
                          'updateNote': true,
                          'noteId': data[index]['journal_id'],
                          'title': data[index]['title'] ?? '',
                          'body': data[index]['body'] ?? ''
                        });
                      },
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('E').format(date),
                            style: TT.f12w700,
                          ),
                          Text(date.day.toString(), style: TT.f12w700)
                        ],
                      ),
                      title: Text(
                        data[index]['title'] ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TT.f14w600,
                      ),
                      subtitle: Text(
                        data[index]['body'] ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TT.f12w500,
                      ),
                    ),
                  );
                });
          }
        },
        error: (error, stackTrace) => Center(
          child: Text(error.toString()),
        ),
        loading: () => const CustomShimmer(numberOfCards: 5),
      )),
    );
  }
}
