import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const libroBlue = Color(0xFF087E98);
const libroBlueDark = Color(0xFF04566B);
const libroCyan = Color(0xFF16A6BE);
const pageBg = Color(0xFFF4FAFC);
const ink = Color(0xFF17313A);
const muted = Color(0xFF6C7F86);

void main() {
  runApp(const LibroLinkApp());
}

class UserAccount {
  final String fullName;
  final String email;
  final String password;
  final String studentId;
  final String course;
  final String yearLevel;
  final String department;
  final String phone;
  final String role;

  const UserAccount({
    required this.fullName,
    required this.email,
    required this.password,
    this.studentId = 'MDC-2026-0001',
    this.course = 'Bachelor of Science in Information Technology',
    this.yearLevel = '3rd Year',
    this.department = 'College of Arts, Sciences and Technology',
    this.phone = '+63 900 000 0000',
    this.role = 'Student',
  });
}

class BookItem {
  final String title;
  final String author;
  final String category;
  final String description;
  final IconData icon;

  const BookItem({
    required this.title,
    required this.author,
    required this.category,
    required this.description,
    required this.icon,
  });
}

class Reservation {
  final String name;
  final String idNumber;
  final String gender;
  final String seat;
  final String time;
  final String date;
  final String course;
  final String purpose;

  const Reservation({
    required this.name,
    required this.idNumber,
    required this.gender,
    required this.seat,
    required this.time,
    required this.date,
    required this.course,
    required this.purpose,
  });
}

class LibroLinkApp extends StatefulWidget {
  const LibroLinkApp({super.key});

  @override
  State<LibroLinkApp> createState() => _LibroLinkAppState();
}

class _LibroLinkAppState extends State<LibroLinkApp> {
  ThemeMode themeMode = ThemeMode.light;
  UserAccount? currentUser;

  final List<UserAccount> accounts = [
    const UserAccount(
      fullName: 'Demo Student',
      email: 'student@mdc.edu.ph',
      password: '123456',
    ),
  ];

  final List<BookItem> books = const [
    BookItem(
      title: 'Digital Minds: Exploring the Future of Tech',
      author: 'Andrea Salazar',
      category: 'Information Technology',
      description:
          'An introductory exploration of emerging technologies and the way they shape learning, work, and everyday life.',
      icon: Icons.devices_rounded,
    ),
    BookItem(
      title: 'Echoes of the Past',
      author: 'James V. Aragon',
      category: 'Historical Fiction',
      description:
          'A historical fiction story about memory, community, and the people who preserve the lessons of the past.',
      icon: Icons.auto_stories_rounded,
    ),
    BookItem(
      title: 'Intro to Logic & Critical Thinking',
      author: 'Dr. Eliza Montano',
      category: 'Philosophy / Logic',
      description:
          'A student-friendly guide to reasoning, arguments, evidence, and practical critical thinking.',
      icon: Icons.psychology_alt_rounded,
    ),
  ];

  final Set<String> bookmarks = {};
  Reservation? reservation;

  void login(UserAccount account) => setState(() => currentUser = account);
  void logout() => setState(() => currentUser = null);

  void toggleTheme() {
    setState(() {
      themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lightScheme = ColorScheme.fromSeed(
      seedColor: libroBlue,
      brightness: Brightness.light,
    );
    final darkScheme = ColorScheme.fromSeed(
      seedColor: libroBlue,
      brightness: Brightness.dark,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LibroLink',
      themeMode: themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightScheme,
        scaffoldBackgroundColor: pageBg,
        textTheme: GoogleFonts.poppinsTextTheme(),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: ink,
          elevation: 0,
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          color: Colors.white,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.zero,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          labelStyle: const TextStyle(color: muted),
          hintStyle: const TextStyle(color: Color(0xFF9AAAB0)),
          prefixIconColor: libroBlue,
          contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 17),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Color(0xFFD9E7EB)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Color(0xFFD9E7EB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: libroBlue, width: 1.6),
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkScheme,
        scaffoldBackgroundColor: const Color(0xFF0D171A),
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          color: const Color(0xFF142327),
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          margin: EdgeInsets.zero,
        ),
      ),
      home: currentUser == null
          ? LoginScreen(
              accounts: accounts,
              onLogin: login,
              onRegister: (account) {
                setState(() => accounts.add(account));
                login(account);
              },
            )
          : HomeScreen(
              user: currentUser!,
              reservation: reservation,
              onLogout: logout,
              onThemeToggle: toggleTheme,
              isDark: themeMode == ThemeMode.dark,
              books: books,
              bookmarks: bookmarks,
              onBookmark: (title) => setState(() {
                bookmarks.contains(title)
                    ? bookmarks.remove(title)
                    : bookmarks.add(title);
              }),
              onReservation: (value) => setState(() => reservation = value),
            ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  final List<UserAccount> accounts;
  final void Function(UserAccount) onLogin;
  final void Function(UserAccount) onRegister;

  const LoginScreen({
    super.key,
    required this.accounts,
    required this.onLogin,
    required this.onRegister,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool obscure = true;
  String? error;

  void submit() {
    final value = email.text.trim().toLowerCase();
    final account = widget.accounts
        .where((a) => a.email.toLowerCase() == value && a.password == password.text)
        .firstOrNull;

    if (account == null) {
      setState(() => error = 'Invalid email or password.');
      return;
    }
    widget.onLogin(account);
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LibraryBackground(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(26, 30, 26, 30),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: Column(
                  children: [
                    const AppBrand(showTagline: true),
                    const SizedBox(height: 28),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(26),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Welcome back', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: ink)),
                            const SizedBox(height: 5),
                            const Text('Sign in to continue to your library space.', style: TextStyle(color: muted)),
                            const SizedBox(height: 24),
                            TextField(
                              controller: email,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: 'Email address',
                                prefixIcon: Icon(Icons.alternate_email_rounded),
                              ),
                            ),
                            const SizedBox(height: 14),
                            TextField(
                              controller: password,
                              obscureText: obscure,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: const Icon(Icons.lock_outline_rounded),
                                suffixIcon: IconButton(
                                  onPressed: () => setState(() => obscure = !obscure),
                                  icon: Icon(obscure ? Icons.visibility_rounded : Icons.visibility_off_rounded),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () => showInfo(
                                  context,
                                  'Password recovery',
                                  'Password recovery is represented as a UI flow in this prototype. Connect this action to your authentication service for production use.',
                                ),
                                child: const Text('Forgot password?'),
                              ),
                            ),
                            if (error != null) ...[
                              const SizedBox(height: 2),
                              Text(error!, style: const TextStyle(color: Colors.red, fontSize: 13)),
                              const SizedBox(height: 8),
                            ],
                            const SizedBox(height: 6),
                            PrimaryButton(label: 'Sign In', icon: Icons.arrow_forward_rounded, onPressed: submit),
                            const SizedBox(height: 18),
                            const Row(
                              children: [
                                Expanded(child: Divider()),
                                Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text('OR', style: TextStyle(fontSize: 11, color: muted))),
                                Expanded(child: Divider()),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Center(
                              child: TextButton.icon(
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => RegisterScreen(onRegister: widget.onRegister),
                                  ),
                                ),
                                icon: const Icon(Icons.person_add_alt_1_rounded, size: 18),
                                label: const Text('Create a new account'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('Mater Dei College • Library Services', style: TextStyle(fontSize: 11, color: muted)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  final void Function(UserAccount) onRegister;
  const RegisterScreen({super.key, required this.onRegister});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final fullName = TextEditingController();
  final email = TextEditingController();
  final studentId = TextEditingController();
  final course = TextEditingController();
  final password = TextEditingController();
  final confirm = TextEditingController();

  void submit() {
    if ([fullName, email, studentId, course, password, confirm].any((c) => c.text.trim().isEmpty)) {
      showInfo(context, 'Incomplete form', 'Please complete all required fields.');
      return;
    }
    if (password.text != confirm.text) {
      showInfo(context, 'Password mismatch', 'Password and confirm password must match.');
      return;
    }

    widget.onRegister(
      UserAccount(
        fullName: fullName.text.trim(),
        email: email.text.trim(),
        password: password.text,
        studentId: studentId.text.trim(),
        course: course.text.trim(),
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    fullName.dispose();
    email.dispose();
    studentId.dispose();
    course.dispose();
    password.dispose();
    confirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Create Account'),
      body: LibraryBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 36),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 620),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionHeading(title: 'Personal details', subtitle: 'Create your LibroLink student account.'),
                      const SizedBox(height: 22),
                      field('Full name', fullName, Icons.person_outline_rounded),
                      field('Email address', email, Icons.alternate_email_rounded, keyboard: TextInputType.emailAddress),
                      field('Student ID', studentId, Icons.badge_outlined),
                      field('Course / Program', course, Icons.school_outlined),
                      field('Password', password, Icons.lock_outline_rounded, obscure: true),
                      field('Confirm password', confirm, Icons.lock_reset_rounded, obscure: true),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(child: SecondaryButton(label: 'Back', onPressed: () => Navigator.pop(context))),
                          const SizedBox(width: 12),
                          Expanded(child: PrimaryButton(label: 'Create Account', icon: Icons.check_rounded, onPressed: submit)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget field(String label, TextEditingController controller, IconData icon, {bool obscure = false, TextInputType? keyboard}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboard,
        decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon)),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final UserAccount user;
  final Reservation? reservation;
  final VoidCallback onLogout;
  final VoidCallback onThemeToggle;
  final bool isDark;
  final List<BookItem> books;
  final Set<String> bookmarks;
  final void Function(String) onBookmark;
  final void Function(Reservation) onReservation;

  const HomeScreen({
    super.key,
    required this.user,
    required this.reservation,
    required this.onLogout,
    required this.onThemeToggle,
    required this.isDark,
    required this.books,
    required this.bookmarks,
    required this.onBookmark,
    required this.onReservation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: LibroDrawer(
        user: user,
        onLogout: onLogout,
        onThemeToggle: onThemeToggle,
        isDark: isDark,
        books: books,
        bookmarks: bookmarks,
        onBookmark: onBookmark,
        onReservation: onReservation,
      ),
      appBar: const LibroAppBar(),
      body: LibraryBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 8, 22, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text('Good day,', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: muted)),
              Text(user.fullName, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: ink)),
              const SizedBox(height: 4),
              const Text('Your library, connected.', style: TextStyle(color: muted)),
              const SizedBox(height: 22),
              _heroCard(context),
              const SizedBox(height: 22),
              const SectionHeading(title: 'Quick actions', subtitle: 'Everything you need for your next library visit.'),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: ActionCard(
                      icon: Icons.event_seat_rounded,
                      title: 'Reserve a seat',
                      subtitle: 'Check availability',
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SeatReservationScreen(onReservation: onReservation))),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ActionCard(
                      icon: Icons.auto_stories_rounded,
                      title: 'Read books',
                      subtitle: 'Browse the collection',
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => BooksScreen(books: books, bookmarks: bookmarks, onBookmark: onBookmark))),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              if (reservation != null) _reservationCard(context),
              if (reservation == null) _libraryTips(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _heroCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [libroBlueDark, libroBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(color: libroBlue.withValues(alpha: .22), blurRadius: 24, offset: const Offset(0, 12)),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: .13), borderRadius: BorderRadius.circular(30)),
                  child: const Text('LIBRARY CONNECTED', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: .8)),
                ),
                const SizedBox(height: 13),
                const Text('Make your next study session count.', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700, height: 1.25)),
                const SizedBox(height: 8),
                const Text('Reserve a seat or discover something new to read.', style: TextStyle(color: Colors.white70, height: 1.4)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(color: Colors.white.withValues(alpha: .13), shape: BoxShape.circle),
            child: const Icon(Icons.local_library_rounded, color: Colors.white, size: 36),
          ),
        ],
      ),
    );
  }

  Widget _reservationCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(color: const Color(0xFFE5F5F8), borderRadius: BorderRadius.circular(15)),
              child: const Icon(Icons.event_available_rounded, color: libroBlue),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Upcoming reservation', style: TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text('Seat ${reservation!.seat} • ${reservation!.date}', style: const TextStyle(color: muted, fontSize: 12)),
                Text(reservation!.time, style: const TextStyle(color: muted, fontSize: 12)),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _libraryTips() {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(18),
        child: Row(
          children: [
            Icon(Icons.lightbulb_outline_rounded, color: libroBlue, size: 28),
            SizedBox(width: 12),
            Expanded(child: Text('Tip: Reserve your seat before heading to the library so you can plan your study time with confidence.', style: TextStyle(color: muted, height: 1.45))),
          ],
        ),
      ),
    );
  }
}

class LibroAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LibroAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 72,
      leading: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.only(left: 12),
          child: IconButton(
            tooltip: 'Open menu',
            icon: const Icon(Icons.menu_rounded, size: 29),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      title: const CompactBrand(),
      actions: const [SizedBox(width: 12)],
    );
  }
}

class SimpleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const SimpleAppBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
      leading: IconButton(
        tooltip: 'Back',
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back_rounded),
      ),
    );
  }
}

class LibroDrawer extends StatelessWidget {
  final UserAccount user;
  final VoidCallback onLogout;
  final VoidCallback onThemeToggle;
  final bool isDark;
  final List<BookItem> books;
  final Set<String> bookmarks;
  final void Function(String) onBookmark;
  final void Function(Reservation) onReservation;

  const LibroDrawer({
    super.key,
    required this.user,
    required this.onLogout,
    required this.onThemeToggle,
    required this.isDark,
    required this.books,
    required this.bookmarks,
    required this.onBookmark,
    required this.onReservation,
  });

  void go(BuildContext context, Widget page) {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 310,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(22, 20, 18, 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [libroBlueDark, libroBlue]),
              ),
              child: Row(
                children: [
                  ProfileAvatar(name: user.fullName, radius: 28, light: true),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.fullName, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 3),
                        Text(user.email, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white70, fontSize: 11)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(10, 12, 10, 10),
                children: [
                  drawerTile(context, Icons.home_rounded, 'Home', () => Navigator.pop(context), selected: true),
                  drawerTile(context, Icons.event_seat_outlined, 'Reserve Seat', () => go(context, SeatReservationScreen(onReservation: onReservation))),
                  drawerTile(context, Icons.auto_stories_outlined, 'Read Books', () => go(context, BooksScreen(books: books, bookmarks: bookmarks, onBookmark: onBookmark))),
                  drawerTile(context, Icons.bookmark_outline_rounded, 'Bookmarks', () => go(context, BookmarksScreen(books: books, bookmarks: bookmarks, onBookmark: onBookmark))),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10), child: Divider()),
                  drawerTile(context, Icons.person_outline_rounded, 'My Profile', () => go(context, ProfileScreen(user: user))),
                  drawerTile(context, isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined, isDark ? 'Light Mode' : 'Dark Mode', onThemeToggle),
                  drawerTile(context, Icons.help_outline_rounded, 'Help Center', () => go(context, const HelpScreen())),
                  drawerTile(context, Icons.info_outline_rounded, 'About LibroLink', () => go(context, const AboutScreen())),
                ],
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(10),
              child: drawerTile(context, Icons.logout_rounded, 'Log Out', () async {
                Navigator.pop(context);
                final leave = await showDialog<bool>(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Log out of LibroLink?'),
                    content: const Text('Your current prototype session will be ended.'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                      FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Log Out')),
                    ],
                  ),
                );
                if (leave == true) onLogout();
              }, destructive: true),
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerTile(BuildContext context, IconData icon, String title, VoidCallback onTap, {bool selected = false, bool destructive = false}) {
    final color = destructive ? Colors.red.shade700 : selected ? libroBlue : Theme.of(context).colorScheme.onSurface;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        selected: selected,
        selectedTileColor: const Color(0xFFE7F5F8),
        leading: Icon(icon, color: color),
        title: Text(title, style: TextStyle(fontWeight: selected ? FontWeight.w700 : FontWeight.w500, color: destructive ? color : null)),
        trailing: selected ? const Icon(Icons.chevron_right_rounded, color: libroBlue) : null,
        onTap: onTap,
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final UserAccount user;
  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'My Profile'),
      body: LibraryBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 8, 22, 40),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 650),
              child: Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(22, 28, 22, 24),
                      child: Column(
                        children: [
                          ProfileAvatar(name: user.fullName, radius: 54),
                          const SizedBox(height: 15),
                          Text(user.fullName, textAlign: TextAlign.center, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w700, color: ink)),
                          const SizedBox(height: 4),
                          Text(user.role, style: const TextStyle(color: muted)),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                            decoration: BoxDecoration(color: const Color(0xFFE7F5F8), borderRadius: BorderRadius.circular(30)),
                            child: Text(user.studentId, style: const TextStyle(color: libroBlueDark, fontSize: 12, fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SectionHeading(title: 'Student information', subtitle: 'Your account and academic details.'),
                          const SizedBox(height: 18),
                          DetailRow(icon: Icons.badge_outlined, label: 'Student ID', value: user.studentId),
                          DetailRow(icon: Icons.alternate_email_rounded, label: 'Email', value: user.email),
                          DetailRow(icon: Icons.phone_outlined, label: 'Contact number', value: user.phone),
                          DetailRow(icon: Icons.school_outlined, label: 'Course / Program', value: user.course),
                          DetailRow(icon: Icons.calendar_today_outlined, label: 'Year level', value: user.yearLevel),
                          DetailRow(icon: Icons.account_balance_outlined, label: 'Department', value: user.department),
                          DetailRow(icon: Icons.verified_user_outlined, label: 'Account type', value: user.role, last: true),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SeatReservationScreen extends StatefulWidget {
  final void Function(Reservation) onReservation;
  const SeatReservationScreen({super.key, required this.onReservation});

  @override
  State<SeatReservationScreen> createState() => _SeatReservationScreenState();
}

class _SeatReservationScreenState extends State<SeatReservationScreen> {
  final Set<int> occupied = {2, 7, 14, 20, 25};
  final Set<int> reserved = {5, 17};
  int? selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Reserve a Seat'),
      body: LibraryBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 38),
          child: Column(
            children: [
              const SectionHeading(title: 'Choose your seat', subtitle: 'Select an available seat for your library session.'),
              const SizedBox(height: 18),
              Card(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 18, 12, 20),
                  child: Column(
                    children: [
                      Container(
                        width: 150,
                        height: 34,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: const Color(0xFFE8F0F2), borderRadius: BorderRadius.circular(9)),
                        child: const Text('LIBRARY FRONT', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: muted, letterSpacing: .7)),
                      ),
                      const SizedBox(height: 18),
                      for (int row = 0; row < 5; row++)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int col = 0; col < 5; col++) ...[
                                if (col == 2) const SizedBox(width: 25),
                                _seatButton(row * 5 + col + 1),
                              ],
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 18,
                    runSpacing: 10,
                    children: [
                      legend(const Color(0xFFE5EDF0), 'Available'),
                      legend(const Color(0xFFFFE2E2), 'Occupied'),
                      legend(const Color(0xFFE4F5E9), 'Reserved'),
                      legend(const Color(0xFFDDF4F8), 'Selected'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              PrimaryButton(
                label: selected == null ? 'Select a Seat' : 'Continue with Seat ${selected!}',
                icon: Icons.arrow_forward_rounded,
                onPressed: selected == null
                    ? null
                    : () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ReservationFormScreen(
                              seat: selected!,
                              onReservation: widget.onReservation,
                            ),
                          ),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _seatButton(int seat) {
    final isOccupied = occupied.contains(seat);
    final isReserved = reserved.contains(seat);
    final isSelected = selected == seat;
    final available = !isOccupied && !isReserved;
    final bg = isSelected
        ? libroBlue
        : isOccupied
            ? const Color(0xFFFFE2E2)
            : isReserved
                ? const Color(0xFFE4F5E9)
                : const Color(0xFFE5EDF0);
    final fg = isSelected
        ? Colors.white
        : isOccupied
            ? Colors.red.shade700
            : isReserved
                ? Colors.green.shade700
                : libroBlueDark;

    return Padding(
      padding: const EdgeInsets.all(3),
      child: InkWell(
        borderRadius: BorderRadius.circular(11),
        onTap: available ? () => setState(() => selected = seat) : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(11),
            border: Border.all(color: isSelected ? libroBlue : Colors.transparent),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(isOccupied ? Icons.block_rounded : Icons.chair_rounded, size: 16, color: fg),
              const SizedBox(height: 1),
              Text('$seat', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: fg)),
            ],
          ),
        ),
      ),
    );
  }

  Widget legend(Color color, String label) {
    return Row(mainAxisSize: MainAxisSize.min, children: [Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)), const SizedBox(width: 6), Text(label, style: const TextStyle(fontSize: 11, color: muted))]);
  }
}

class ReservationFormScreen extends StatefulWidget {
  final int seat;
  final void Function(Reservation) onReservation;
  const ReservationFormScreen({super.key, required this.seat, required this.onReservation});

  @override
  State<ReservationFormScreen> createState() => _ReservationFormScreenState();
}

class _ReservationFormScreenState extends State<ReservationFormScreen> {
  final first = TextEditingController();
  final middle = TextEditingController();
  final last = TextEditingController();
  final id = TextEditingController();
  final course = TextEditingController();
  final purpose = TextEditingController();
  String gender = 'Male';
  String time = '8:00 AM – 10:00 AM';
  DateTime date = DateTime.now();

  @override
  void dispose() {
    first.dispose();
    middle.dispose();
    last.dispose();
    id.dispose();
    course.dispose();
    purpose.dispose();
    super.dispose();
  }

  Future<void> pickDate() async {
    final value = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
      initialDate: date,
    );
    if (value != null) setState(() => date = value);
  }

  void submit() {
    if (first.text.trim().isEmpty || last.text.trim().isEmpty || id.text.trim().isEmpty || course.text.trim().isEmpty) {
      showInfo(context, 'Incomplete reservation', 'Please fill in your first name, last name, ID number, and course.');
      return;
    }

    final reservation = Reservation(
      name: '${first.text.trim()} ${middle.text.trim()} ${last.text.trim()}'.replaceAll(RegExp(r'\s+'), ' '),
      idNumber: id.text.trim(),
      gender: gender,
      seat: '${widget.seat}',
      time: time,
      date: '${date.month}/${date.day}/${date.year}',
      course: course.text.trim(),
      purpose: purpose.text.trim().isEmpty ? 'Study' : purpose.text.trim(),
    );
    widget.onReservation(reservation);
    Navigator.popUntil(context, (route) => route.isFirst);
    showInfo(context, 'Reservation confirmed', 'Seat ${widget.seat} has been reserved for ${reservation.date} at ${reservation.time}.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Reservation Details'),
      body: LibraryBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 38),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 680),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(color: const Color(0xFFE7F5F8), borderRadius: BorderRadius.circular(16)),
                        child: const Row(children: [Icon(Icons.event_seat_rounded, color: libroBlue), SizedBox(width: 10), Text('Seat selected', style: TextStyle(fontWeight: FontWeight.w700)), Spacer(), Text('Seat details below')]),
                      ),
                      const SizedBox(height: 20),
                      const SectionHeading(title: 'Student details', subtitle: 'Provide the information needed for your reservation.'),
                      const SizedBox(height: 18),
                      formField('First name *', first, Icons.person_outline_rounded),
                      formField('Middle name', middle, Icons.person_outline_rounded),
                      formField('Last name *', last, Icons.person_outline_rounded),
                      formField('ID number *', id, Icons.badge_outlined),
                      formField('Course / Program *', course, Icons.school_outlined),
                      DropdownButtonFormField<String>(
                        initialValue: gender,
                        decoration: const InputDecoration(labelText: 'Gender', prefixIcon: Icon(Icons.wc_outlined)),
                        items: const ['Male', 'Female', 'Prefer not to say'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                        onChanged: (value) => setState(() => gender = value ?? gender),
                      ),
                      const SizedBox(height: 14),
                      DropdownButtonFormField<String>(
                        initialValue: time,
                        decoration: const InputDecoration(labelText: 'Time slot', prefixIcon: Icon(Icons.schedule_outlined)),
                        items: const ['8:00 AM – 10:00 AM', '10:00 AM – 12:00 PM', '1:00 PM – 3:00 PM', '3:00 PM – 5:00 PM'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                        onChanged: (value) => setState(() => time = value ?? time),
                      ),
                      const SizedBox(height: 14),
                      InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: pickDate,
                        child: InputDecorator(
                          decoration: const InputDecoration(labelText: 'Reservation date', prefixIcon: Icon(Icons.calendar_month_outlined)),
                          child: Text('${date.month}/${date.day}/${date.year}'),
                        ),
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        controller: purpose,
                        maxLines: 3,
                        decoration: const InputDecoration(labelText: 'Purpose (optional)', prefixIcon: Icon(Icons.notes_rounded), alignLabelWithHint: true),
                      ),
                      const SizedBox(height: 22),
                      PrimaryButton(label: 'Confirm Reservation', icon: Icons.check_circle_outline_rounded, onPressed: submit),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formField(String label, TextEditingController controller, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(controller: controller, decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon))),
    );
  }
}

class BooksScreen extends StatefulWidget {
  final List<BookItem> books;
  final Set<String> bookmarks;
  final void Function(String) onBookmark;

  const BooksScreen({super.key, required this.books, required this.bookmarks, required this.onBookmark});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = widget.books.where((book) {
      final q = query.toLowerCase();
      return book.title.toLowerCase().contains(q) || book.author.toLowerCase().contains(q) || book.category.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      appBar: const SimpleAppBar(title: 'Digital Library'),
      body: LibraryBackground(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 35),
          children: [
            const SectionHeading(title: 'Discover something new', subtitle: 'Browse books and save your favorites for later.'),
            const SizedBox(height: 16),
            TextField(
              onChanged: (value) => setState(() => query = value),
              decoration: const InputDecoration(hintText: 'Search title, author, or category', prefixIcon: Icon(Icons.search_rounded)),
            ),
            const SizedBox(height: 18),
            if (filtered.isEmpty)
              const Padding(padding: EdgeInsets.all(30), child: Center(child: Text('No books matched your search.', style: TextStyle(color: muted))))
            else
              ...filtered.map(
                (book) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: BookCard(
                    book: book,
                    saved: widget.bookmarks.contains(book.title),
                    onBookmark: () {
                      widget.onBookmark(book.title);
                      setState(() {});
                    },
                    onRead: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ReaderScreen(book: book))),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class BookmarksScreen extends StatelessWidget {
  final List<BookItem> books;
  final Set<String> bookmarks;
  final void Function(String) onBookmark;

  const BookmarksScreen({super.key, required this.books, required this.bookmarks, required this.onBookmark});

  @override
  Widget build(BuildContext context) {
    final saved = books.where((b) => bookmarks.contains(b.title)).toList();
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Bookmarks'),
      body: LibraryBackground(
        child: saved.isEmpty
            ? const Center(child: Text('No saved books yet.', style: TextStyle(color: muted)))
            : ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 35),
                children: saved
                    .map(
                      (book) => Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: BookCard(
                          book: book,
                          saved: true,
                          onBookmark: () => onBookmark(book.title),
                          onRead: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ReaderScreen(book: book))),
                        ),
                      ),
                    )
                    .toList(),
              ),
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final BookItem book;
  final bool saved;
  final VoidCallback onBookmark;
  final VoidCallback onRead;

  const BookCard({super.key, required this.book, required this.saved, required this.onBookmark, required this.onRead});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 88,
              height: 122,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFFDFF4F7), Color(0xFFF0FAFB)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(book.icon, size: 42, color: libroBlue),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(book.category.toUpperCase(), style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: libroBlue, letterSpacing: .7)),
                  const SizedBox(height: 5),
                  Text(book.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15, height: 1.25)),
                  const SizedBox(height: 5),
                  Text(book.author, style: const TextStyle(fontSize: 11, color: muted)),
                  const SizedBox(height: 8),
                  Text(book.description, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 10.5, color: muted, height: 1.35)),
                  const SizedBox(height: 9),
                  Row(
                    children: [
                      Expanded(child: SizedBox(height: 36, child: FilledButton.icon(onPressed: onRead, icon: const Icon(Icons.menu_book_rounded, size: 16), label: const Text('Read', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700))))),
                      IconButton(tooltip: saved ? 'Remove bookmark' : 'Bookmark', onPressed: onBookmark, icon: Icon(saved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded, color: libroBlue)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReaderScreen extends StatefulWidget {
  final BookItem book;
  const ReaderScreen({super.key, required this.book});

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  double size = 17;
  bool dark = false;

  @override
  Widget build(BuildContext context) {
    final background = dark ? const Color(0xFF11191B) : const Color(0xFFFFFEFA);
    final foreground = dark ? Colors.white : ink;

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text(widget.book.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
        backgroundColor: dark ? const Color(0xFF182224) : Colors.white,
        foregroundColor: foreground,
        actions: [
          IconButton(onPressed: () => setState(() => size = (size + 1).clamp(14, 26)), tooltip: 'Increase text size', icon: const Icon(Icons.text_increase_rounded)),
          IconButton(onPressed: () => setState(() => dark = !dark), tooltip: 'Reader theme', icon: Icon(dark ? Icons.light_mode_rounded : Icons.dark_mode_rounded)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 55),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Icon(widget.book.icon, size: 68, color: libroBlue)),
                const SizedBox(height: 18),
                Center(child: Text(widget.book.title, textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: foreground, height: 1.25))),
                const SizedBox(height: 7),
                Center(child: Text(widget.book.author, style: TextStyle(color: dark ? Colors.white60 : muted))),
                const SizedBox(height: 34),
                Text('Chapter 1', style: TextStyle(fontSize: size + 4, fontWeight: FontWeight.w700, color: foreground)),
                const SizedBox(height: 14),
                Text(
                  'Learning begins with curiosity. Every question opens a path toward understanding, and every book gives us another way to explore that path. In this digital reading space, students can access resources wherever they are and continue learning at their own pace.',
                  style: TextStyle(fontSize: size, height: 1.7, color: foreground),
                ),
                const SizedBox(height: 22),
                Text(
                  'The library is more than a room filled with books. It is a shared space for discovery, reflection, collaboration, and independent study. LibroLink brings part of that experience to a mobile device while keeping the physical library experience simple and organized.',
                  style: TextStyle(fontSize: size, height: 1.7, color: foreground),
                ),
                const SizedBox(height: 22),
                Text(
                  'Continue reading to explore the ideas, examples, and activities included in this digital copy.',
                  style: TextStyle(fontSize: size, height: 1.7, color: foreground),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'About LibroLink'),
      body: LibraryBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 8, 22, 40),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Container(width: 76, height: 76, decoration: BoxDecoration(color: const Color(0xFFE5F5F8), borderRadius: BorderRadius.circular(24)), child: const Icon(Icons.local_library_rounded, color: libroBlue, size: 40)),
                          const SizedBox(height: 15),
                          const Text('LIBROLINK', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800, color: libroBlue)),
                          const SizedBox(height: 4),
                          const Text('Linking You to Learning, One Seat at a Time.', textAlign: TextAlign.center, style: TextStyle(color: muted, fontSize: 12)),
                          const SizedBox(height: 22),
                          const Text(
                            'LibroLink is a student-focused mobile application concept for Mater Dei College library services. It brings seat reservation and digital reading into one organized mobile experience.',
                            textAlign: TextAlign.center,
                            style: TextStyle(height: 1.6, color: muted),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SectionHeading(title: 'What you can do', subtitle: 'Core LibroLink features.'),
                          SizedBox(height: 18),
                          FeatureRow(icon: Icons.event_seat_rounded, title: 'Reserve a seat', text: 'View a visual seat map, select an available seat, and submit a reservation.'),
                          FeatureRow(icon: Icons.auto_stories_rounded, title: 'Read digital books', text: 'Browse the collection, open a reading view, and adjust text size for comfort.'),
                          FeatureRow(icon: Icons.bookmark_rounded, title: 'Save bookmarks', text: 'Keep books you want to revisit in one convenient place.'),
                          FeatureRow(icon: Icons.person_outline_rounded, title: 'Manage your profile', text: 'View your student identity and account information from a dedicated profile page.'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(22),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('Prototype information', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                        SizedBox(height: 10),
                        Text('Version 1.0.0', style: TextStyle(color: muted)),
                        Text('Mater Dei College Library Services', style: TextStyle(color: muted)),
                        Text('Client-ready UI prototype • Flutter', style: TextStyle(color: muted)),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SimpleAppBar(title: 'Help Center'),
      body: LibraryBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 8, 22, 40),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: const Column(
                children: [
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SectionHeading(title: 'How can we help?', subtitle: 'A quick guide to the main LibroLink features.'),
                          SizedBox(height: 18),
                          HelpStep(number: '01', title: 'Create an account', text: 'Use the Register option on the login screen and provide the required student details.'),
                          HelpStep(number: '02', title: 'Sign in', text: 'Enter your registered email address and password to open the home screen.'),
                          HelpStep(number: '03', title: 'Reserve a seat', text: 'Open Reserve a Seat, choose an available seat, complete the reservation form, and confirm.'),
                          HelpStep(number: '04', title: 'Read books', text: 'Open Digital Library, search the collection, and tap Read to enter the reader.'),
                          HelpStep(number: '05', title: 'Use bookmarks', text: 'Tap the bookmark icon on any book to save it. Saved books are available from the Bookmarks page.'),
                          HelpStep(number: '06', title: 'Manage your profile', text: 'Open the menu and choose My Profile to view your account and student information.'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 14),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(22),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('Need more assistance?', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                        SizedBox(height: 7),
                        Text('For a production deployment, connect this section to the college library help desk, support email, FAQ database, or ticketing service.', style: TextStyle(color: muted, height: 1.5)),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LibraryBackground extends StatelessWidget {
  final Widget child;
  const LibraryBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: Theme.of(context).brightness == Brightness.dark
                    ? const [Color(0xFF0D171A), Color(0xFF10262B)]
                    : const [pageBg, Color(0xFFEAF7FA)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        Positioned(top: -70, right: -45, child: _bubble(170, libroCyan.withValues(alpha: .07))),
        Positioned(top: 240, left: -95, child: _bubble(190, libroBlue.withValues(alpha: .05))),
        Positioned(bottom: -100, right: -70, child: _bubble(220, libroCyan.withValues(alpha: .05))),
        Positioned.fill(child: child),
      ],
    );
  }

  Widget _bubble(double size, Color color) => Container(width: size, height: size, decoration: BoxDecoration(color: color, shape: BoxShape.circle));
}

class AppBrand extends StatelessWidget {
  final bool showTagline;
  final bool light;
  const AppBrand({super.key, required this.showTagline, this.light = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                gradient: light ? null : const LinearGradient(colors: [libroBlueDark, libroBlue]),
                color: light ? Colors.white : null,
                borderRadius: BorderRadius.circular(16),
                boxShadow: light ? null : [BoxShadow(color: libroBlue.withValues(alpha: .16), blurRadius: 15, offset: const Offset(0, 7))],
              ),
              child: Icon(Icons.menu_book_rounded, color: light ? libroBlue : Colors.white, size: 31),
            ),
            const SizedBox(width: 11),
            RichText(
              text: TextSpan(
                style: GoogleFonts.poppins(fontSize: 31, fontWeight: FontWeight.w800),
                children: [
                  TextSpan(text: 'LIBRO', style: TextStyle(color: light ? Colors.white : libroBlue)),
                  TextSpan(text: 'LINK', style: TextStyle(color: light ? Colors.white : ink)),
                ],
              ),
            ),
          ],
        ),
        if (showTagline) ...[
          const SizedBox(height: 7),
          Text('Linking You to Learning, One Seat at a Time.', textAlign: TextAlign.center, style: TextStyle(fontSize: 10.5, color: light ? Colors.white70 : muted)),
        ],
      ],
    );
  }
}

class CompactBrand extends StatelessWidget {
  const CompactBrand({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 34, height: 34, decoration: BoxDecoration(color: libroBlue, borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.menu_book_rounded, color: Colors.white, size: 21)),
        const SizedBox(width: 9),
        const Text('LIBROLINK', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: libroBlue, letterSpacing: .4)),
      ],
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  final String name;
  final double radius;
  final bool light;

  const ProfileAvatar({super.key, required this.name, required this.radius, this.light = false});

  @override
  Widget build(BuildContext context) {
    final initials = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .take(2)
        .map((part) => part[0].toUpperCase())
        .join();

    return CircleAvatar(
      radius: radius,
      backgroundColor: light ? Colors.white : const Color(0xFFDDF4F8),
      child: CircleAvatar(
        radius: radius - 4,
        backgroundColor: light ? libroBlue : Colors.white,
        child: Text(initials.isEmpty ? 'U' : initials, style: TextStyle(color: light ? Colors.white : libroBlue, fontSize: radius * .48, fontWeight: FontWeight.w800)),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;

  const PrimaryButton({super.key, required this.label, this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: FilledButton.icon(
        onPressed: onPressed,
        icon: icon == null ? const SizedBox.shrink() : Icon(icon, size: 19),
        label: Text(label, style: const TextStyle(fontWeight: FontWeight.w700, letterSpacing: .1)),
        style: FilledButton.styleFrom(
          backgroundColor: libroBlue,
          foregroundColor: Colors.white,
          disabledBackgroundColor: const Color(0xFFB9D4DA),
          disabledForegroundColor: Colors.white,
          elevation: 2,
          shadowColor: libroBlue.withValues(alpha: .25),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const SecondaryButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: libroBlueDark,
          side: const BorderSide(color: Color(0xFFBCD7DD)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
      ),
    );
  }
}

class SectionHeading extends StatelessWidget {
  final String title;
  final String subtitle;
  const SectionHeading({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700, color: ink)),
        const SizedBox(height: 3),
        Text(subtitle, style: const TextStyle(fontSize: 11.5, color: muted, height: 1.35)),
      ],
    );
  }
}

class ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const ActionCard({super.key, required this.icon, required this.title, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 18, 15, 17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(width: 44, height: 44, decoration: BoxDecoration(color: const Color(0xFFE5F5F8), borderRadius: BorderRadius.circular(14)), child: Icon(icon, color: libroBlue, size: 23)),
              const SizedBox(height: 15),
              Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
              const SizedBox(height: 3),
              Text(subtitle, style: const TextStyle(fontSize: 10, color: muted)),
              const SizedBox(height: 12),
              const Align(alignment: Alignment.centerRight, child: Icon(Icons.arrow_forward_rounded, color: libroBlue, size: 18)),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool last;
  const DetailRow({super.key, required this.icon, required this.label, required this.value, this.last = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13),
      decoration: BoxDecoration(border: last ? null : const Border(bottom: BorderSide(color: Color(0xFFE6EEF0)))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: libroBlue, size: 21),
          const SizedBox(width: 12),
          SizedBox(width: 105, child: Text(label, style: const TextStyle(fontSize: 11, color: muted))),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, height: 1.35))),
        ],
      ),
    );
  }
}

class FeatureRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;
  const FeatureRow({super.key, required this.icon, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(width: 42, height: 42, decoration: BoxDecoration(color: const Color(0xFFE5F5F8), borderRadius: BorderRadius.circular(13)), child: Icon(icon, color: libroBlue, size: 21)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.w700)), const SizedBox(height: 3), Text(text, style: const TextStyle(color: muted, fontSize: 11.5, height: 1.45))])),
      ]),
    );
  }
}

class HelpStep extends StatelessWidget {
  final String number;
  final String title;
  final String text;
  const HelpStep({super.key, required this.number, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(width: 42, height: 42, alignment: Alignment.center, decoration: BoxDecoration(color: const Color(0xFFE5F5F8), borderRadius: BorderRadius.circular(13)), child: Text(number, style: const TextStyle(color: libroBlue, fontWeight: FontWeight.w800, fontSize: 11))),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.w700)), const SizedBox(height: 3), Text(text, style: const TextStyle(color: muted, fontSize: 11.5, height: 1.45))])),
      ]),
    );
  }
}

void showInfo(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
      content: Text(message, style: const TextStyle(height: 1.45)),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
    ),
  );
}

extension FirstOrNull<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
