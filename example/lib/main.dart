import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soical_user_authentication/soical_user_authentication.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SoicalUserProvider>(
          create: (_) => SoicalUserProvider(
            soicalUserRepository: SoicalUserRepository(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Consumer<SoicalUserProvider>(
        builder: (context, authProvider, _) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                authProvider.isLoading
                    ? const SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(),
                      )
                    : const SizedBox.shrink(),
                Text(
                    'Current Soical User: ${SoicalUserProvider.of(context).currentSoicalUser?.name.toString()}'),
                const SigninFacebookButton(),
                const SigninGoogleButton(),
                const LogoutButton()
              ],
            ),
          );
        },
      ),
    );
  }
}
