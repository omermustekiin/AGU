/*
class ScreenLayout extends StatefulWidget {
  final int selectedIndex;

  const ScreenLayout({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {
  late int currentIndex = widget.selectedIndex;
  late Widget _currentScreen;
  final PageController pageController = PageController();
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();
    _currentScreen = _getScreen(currentIndex);
    // Provider.of<UserDetailsProvider>(context, listen: false).getUserName();
  }

  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const ChatScreen();
      case 2:
        return const NotificationsScreen();
      case 3:
        return const ProfileScreen();
      case 4:
        return const PublicDiaryScreen();
      case 5:
        return const PrivateDiaryScreen();
      case 6:
        return const FollowingsScreen();
      case 7:
        return const SettingsScreen();
      case 8:
        return const SavedScreen();
      default:
        return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyNavigationDrawer(),
      appBar: const NavBar(),
      body: PageStorage(
        bucket: bucket,
        child: _currentScreen,
      ),
    );
  }
}
*/
