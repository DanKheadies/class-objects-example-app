import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'package:class_objects_example_app/blocs/blocs.dart';
import 'package:class_objects_example_app/models/models.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;

  @override
  void initState() {
    super.initState();

    // context.read<UserBloc>().add(
    //       LoadUser(),
    //     );

    // print(david);
    // print(User.davidUser);
    // print(User.oluUser);

    // david.copyWith(
    //   organization: 'PortCool',
    //   password: 'ABetterPassword123',
    // );

    // setState(() {});

    // print(david);
  }

  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.abc,
            ),
            onPressed: () {
              context.read<UserBloc>().add(
                    LoadUser(),
                  );
            },
          ),
        ],
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state.userStatus == UserStatus.initial ||
              state.userStatus == UserStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.userStatus == UserStatus.loaded) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: double.infinity),
                Text(state.user.name),
                const SizedBox(height: 10),
                Text(state.user.email),
                const SizedBox(height: 10),
                Text(state.user.password),
                const SizedBox(height: 10),
                state.isCool != null && state.isCool!
                    ? Text('isCool: ${state.isCool}')
                    : const SizedBox(),
                const SizedBox(height: 50),
              ],
            );
          } else {
            return const Center(
              child: Text('Something went wrong.'),
            );
          }
          // return Center(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       const Text(
          //         'You have pushed the button this many times:',
          //       ),
          //       Text(
          //         '$_counter',
          //         style: Theme.of(context).textTheme.headlineMedium,
          //       ),
          //     ],
          //   ),
          // );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              // onPressed: _incrementCounter,
              onPressed: () {
                context.read<UserBloc>().add(
                      const UpdateUser(
                        user: User.davidUser,
                        isCool: false,
                      ),
                    );
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
            FloatingActionButton(
              // onPressed: _incrementCounter,
              onPressed: () {
                // context.read<UserBloc>().add(
                //       const UpdateUser(
                //         user: User.emptyUser,
                //         isCool: false,
                //       ),
                //     );
                context.read<UserBloc>().add(
                      ClearUser(),
                    );
              },
              tooltip: 'Decrement',
              child: const Icon(Icons.minor_crash_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
