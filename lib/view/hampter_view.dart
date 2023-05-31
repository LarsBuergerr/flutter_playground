import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/hampter.dart';
import '../common/providers.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hampterList = ref.watch(providers.hampterControllerProvider);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          floatingActionButton: const AddHampterButton(),
          appBar: AppBar(
            title: const Text('First Flutter App'),
          ),
          body: hampterList.isNotEmpty
              ? ListView.builder(
                  itemCount: hampterList.length,
                  itemBuilder: (context, index) {
                    final hampter = hampterList[index];
                    return Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.grey, width: 1))),
                      child: Row(
                        children: [
                          Flexible(
                            // set to center
                            child: ListTile(
                              title: Text(hampter.name),
                              subtitle: Text(hampter.description),
                            ),
                          ),
                          IconButton(
                            highlightColor: null,
                            icon: const Icon(Icons.delete),
                            onPressed: () => ref
                                .read(providers
                                    .hampterControllerProvider.notifier)
                                .removeHampter(hampter),
                          )
                        ],
                      ),
                    );
                  },
                )
              : const Center(child: Text('No Hampters; Try adding some!'))),
    );
  }
}

class _AddHampterButtonState extends ConsumerState<ConsumerStatefulWidget> {
  String name = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    final hampterListController =
        ref.read(providers.hampterControllerProvider.notifier);
    return FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Add Hampter'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      onChanged: (value) => name = value,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                      ),
                    ),
                    TextField(
                      onChanged: (value) => description = value,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      hampterListController.addHampter(
                          Hampter(name: name, description: description));
                      Navigator.pop(context);
                    },
                    child: const Text('Add'),
                  ),
                ],
              ),
            ));
  }
}

class AddHampterButton extends ConsumerStatefulWidget {
  const AddHampterButton({Key? key}) : super(key: key);

  @override
  _AddHampterButtonState createState() => _AddHampterButtonState();
}

// controller interface
abstract class HampterListController extends StateNotifier<List<Hampter>> {
  HampterListController(List<Hampter> state) : super(state);

  void addHampter(Hampter hampter);

  void removeHampter(Hampter hampter);
}
