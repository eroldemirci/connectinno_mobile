import 'package:auto_route/auto_route.dart';
import 'package:connectinno_case/core/routing/routing.gr.dart';
import 'package:connectinno_case/ui/shared/base_page.dart';
import 'package:connectinno_case/ui/shared/custom_appbar.dart';
import 'package:connectinno_case/ui/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/notes_list.dart';
import 'viewmodel/home_cubit.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<HomeCubit>().fetchNotes());
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBar: CustomAppBar(titleText: "Notes", centerTitle: true, autoImplementLeading: false,),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushRoute(NoteDetailsRoute());
        },
        backgroundColor: AppColors.primaryBlackColor,
        foregroundColor: AppColors.primaryWhiteColor,
        child: const Icon(Icons.add),
      ),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                await context.read<HomeCubit>().fetchNotes();
              },
              child: NotesList(notes: state.notes),
            );
          } else if (state is HomeError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
