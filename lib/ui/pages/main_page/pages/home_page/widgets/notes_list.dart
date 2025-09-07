import 'package:auto_route/auto_route.dart';
import 'package:connectinno_case/core/models/note_model.dart';
import 'package:connectinno_case/core/routing/routing.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import '../viewmodel/home_cubit.dart';

class NotesList extends StatelessWidget {
  final List<NoteModel> notes;
  const NotesList({Key? key, required this.notes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (notes.isEmpty) {
      return const Center(child: Text('No notes found.'));
    }
    return ListView.separated(
      itemCount: notes.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        final note = notes[index];
        return Dismissible(
          key: ValueKey(note.id),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            color: Colors.red,
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          confirmDismiss: (direction) async {
            return await _showDeleteDialog(context);
          },
          onDismissed: (_) {
            context.read<HomeCubit>().deleteNote(note.id!);
          },
          child: ListTile(
            title: Text(note.title),
            subtitle: Text(note.content, maxLines: 2, overflow: TextOverflow.ellipsis),
            trailing: Text(_formatDate(note.updatedAt), style: const TextStyle(fontSize: 12, color: Colors.grey)),
            onTap: () {
              context.router.push(NoteDetailsRoute(note: note));
            },
          ),
        );
      },
    );
  }

  Future<bool?> _showDeleteDialog(BuildContext context) async {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return await showDialog<bool>(
        context: context,
        builder:
            (ctx) => CupertinoAlertDialog(
              title: const Text('Notu Sil'),
              content: const Text('Bu notu silmek istediğinize emin misiniz?'),
              actions: [
                CupertinoDialogAction(child: const Text('Vazgeç'), onPressed: () => Navigator.of(ctx).pop(false)),
                CupertinoDialogAction(isDestructiveAction: true, child: const Text('Evet'), onPressed: () => Navigator.of(ctx).pop(true)),
              ],
            ),
      );
    } else {
      return await showDialog<bool>(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: const Text('Notu Sil'),
              content: const Text('Bu notu silmek istediğinize emin misiniz?'),
              actions: [
                TextButton(child: const Text('Vazgeç'), onPressed: () => Navigator.of(ctx).pop(false)),
                TextButton(child: const Text('Evet'), onPressed: () => Navigator.of(ctx).pop(true)),
              ],
            ),
      );
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}.${date.month}.${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}
