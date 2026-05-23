import 'package:flutter/material.dart';

void main() {
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff070B14),
        fontFamily: 'Poppins',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [

          /// SIDEBAR
          Container(
            width: 250,
            color: const Color(0xff0B1020),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.deepPurple,
                      child: Icon(Icons.note, color: Colors.white),
                    ),
                    SizedBox(width: 12),
                    Text(
                      "NoteNest",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 30),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Colors.deepPurple,
                        Color(0xff7C4DFF),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "New Note",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 35),

                menuItem(Icons.grid_view_rounded, "All Notes", true),
                menuItem(Icons.favorite_border, "Favorites", false),
                menuItem(Icons.access_time, "Recent", false),
                menuItem(Icons.notifications_none, "Reminders", false),
                menuItem(Icons.delete_outline, "Trash", false),

                const Spacer(),

                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xff5B21B6),
                        Color(0xff7C3AED),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Upgrade Pro ✨",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Unlock premium features and cloud sync.",
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

          /// MAIN CONTENT
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// TOP BAR
                  Row(
                    children: [

                      Expanded(
                        child: Container(
                          height: 60,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xff111827),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.search, color: Colors.grey),
                              SizedBox(width: 10),
                              Text(
                                "Search notes, tags or anything...",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(width: 20),

                      const CircleAvatar(
                        radius: 24,
                        backgroundColor: Color(0xff111827),
                        child: Icon(Icons.notifications_none,
                            color: Colors.white),
                      ),

                      const SizedBox(width: 15),

                      const CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.deepPurple,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  /// BANNER
                  Container(
                    height: 200,
                    width: double.infinity,
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xff111827),
                          Color(0xff312E81),
                        ],
                      ),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Your Ideas, Organized 🚀",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Manage tasks, notes and projects in one premium workspace.",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 17,
                          ),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Recent Notes",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 1.1,
                      children: const [
                        NoteCard(
                          title: "Project Roadmap",
                          desc: "Plan product roadmap and milestones.",
                          color: Color(0xff1E1B4B),
                          icon: Icons.push_pin,
                        ),
                        NoteCard(
                          title: "Study Plan",
                          desc: "Prepare for exams and assignments.",
                          color: Color(0xff052E16),
                          icon: Icons.menu_book,
                        ),
                        NoteCard(
                          title: "Meeting Notes",
                          desc: "Discuss UI improvements and features.",
                          color: Color(0xff0C4A6E),
                          icon: Icons.groups,
                        ),
                        NoteCard(
                          title: "Daily Journal",
                          desc: "Write thoughts and daily progress.",
                          color: Color(0xff4A044E),
                          icon: Icons.edit_note,
                        ),
                        NoteCard(
                          title: "Workout Plan",
                          desc: "Track fitness and health goals.",
                          color: Color(0xff082F49),
                          icon: Icons.fitness_center,
                        ),
                        NoteCard(
                          title: "Travel Plan",
                          desc: "Organize trip and bookings.",
                          color: Color(0xff172554),
                          icon: Icons.flight,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  static Widget menuItem(IconData icon, String title, bool active) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      decoration: BoxDecoration(
        color: active
            ? Colors.deepPurple.withOpacity(0.25)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70),
          const SizedBox(width: 15),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  final String title;
  final String desc;
  final Color color;
  final IconData icon;

  const NoteCard({
    super.key,
    required this.title,
    required this.desc,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: color.withOpacity(0.4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.1),
                child: Icon(icon, color: Colors.white),
              ),
              const Icon(Icons.more_vert, color: Colors.white70)
            ],
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            desc,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}