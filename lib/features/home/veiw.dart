import 'package:flutter/material.dart';
import 'package:note_app/core/caching_utils.dart';
import 'package:note_app/core/dimentions.dart';
import 'package:note_app/core/route_utils/route_utils.dart';
import 'package:note_app/features/home/cubit.dart';
import 'package:note_app/features/home/state.dart';
import 'package:note_app/features/login/view.dart';
import 'package:note_app/features/note_details/veiw.dart';
import 'package:note_app/features/note_editor/veiw.dart';
import 'package:note_app/widget/app/app_aapbar.dart';
import 'package:note_app/widget/app/app_colors.dart';
import 'package:note_app/widget/app/app_icon_button.dart';
import 'package:note_app/widget/app/app_loading_indicator.dart';
import 'package:note_app/widget/app/app_text.dart';
import 'package:note_app/widget/app/create_your_first_note_vector.dart';
import 'package:note_app/widget/app/note_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getNotes(),
      child: Scaffold(
        appBar: AppAppBar(
          title: 'Notes',
          actions: [
            const SizedBox(
              width: 20,
            ),
            AppIconButton(
              icon: FontAwesomeIcons.circleInfo,
              onTap: () async {
                await CachingUtils.deleteUser();
                RouteUtils.pushAndPopAll(
                  const LoginView(),
                );
              },
            ),
            const SizedBox(
              width: 16,
            )
          ],
        ),
        body: BlocBuilder<HomeCubit, HomeStates>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const AppLoadingIndicator();
            }
            final cubit = BlocProvider.of<HomeCubit>(context);
            if (cubit.notes.isEmpty) {
              return const CreateYourFirstNoteVector();
            }
            final notes = cubit.notes;
            return RefreshIndicator(
              onRefresh: cubit.getNotes,
              color: AppColors.white,
              child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: notes.length + 1,
                  itemBuilder: (context, index) {
                    if (notes.length == index) {
                      if (state is HomeMoreLoading) {
                        return const AppLoadingIndicator();
                      } else if (cubit.totalNotePages ==
                          cubit.currentNotesPage) {
                        return const SizedBox.shrink();
                      }
                      return Container(
                        margin: const EdgeInsets.only(bottom: 34),
                        alignment: Alignment.center,
                        child: AppText(
                          title: 'View More',
                          fontSize: 18,
                          textDecoration: TextDecoration.underline,
                          onTap: cubit.getMoreNotes,
                        ),
                      );
                    }
                    return NoteCard(
                      note: notes[index],
                      onTap: () {
                        RouteUtils.push(
                          BlocProvider.value(
                            value: cubit,
                            child: NoteDetailsView(id: notes[index].id),
                          ),
                        );
                      },
                      onDismiss: () => cubit.deleteNotes(notes[index]),
                    );
                  }),
            );
          },
        ),
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
            child: Icon(
              FontAwesomeIcons.plus,
              size: 24.height,
            ),
            onPressed: () async {
              await RouteUtils.push(
                BlocProvider.value(
                  value: BlocProvider.of<HomeCubit>(context),
                  child: const NoteEditorView(),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
