import 'package:flutter/material.dart';

void main() {
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

// Enum to manage active sidebar views
enum SelectedView { all, favorites, recent, reminders, archive, trash }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// THEME
  bool isDarkMode = true;

  /// ACTIVE SIDEBAR VIEW
  SelectedView currentView = SelectedView.all;

  /// NOTES DATA
  List<Map<String, dynamic>> notes = [
    {
      "title": "Project Roadmap",
      "desc": "Plan product roadmap and milestones.",
      "color": const Color(0xff1E1B4B),
      "icon": Icons.push_pin,
      "archived": false,
      "favorite": true,
      "trash": false,
      "reminder": "Tomorrow, 10:00 AM",
      "createdAt": DateTime.now().subtract(const Duration(hours: 3)),
    },
    {
      "title": "Study Plan",
      "desc": "Prepare for exams and assignments.",
      "color": const Color(0xff052E16),
      "icon": Icons.menu_book,
      "archived": false,
      "favorite": false,
      "trash": false,
      "reminder": null,
      "createdAt": DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      "title": "Meeting Notes",
      "desc": "Discuss UI improvements and features.",
      "color": const Color(0xff0C4A6E),
      "icon": Icons.groups,
      "archived": false,
      "favorite": true,
      "trash": false,
      "reminder": "Friday, 2:00 PM",
      "createdAt": DateTime.now().subtract(const Duration(minutes: 45)),
    },
    {
      "title": "Workout Plan",
      "desc": "Track fitness and health goals.",
      "color": const Color(0xff082F49),
      "icon": Icons.fitness_center,
      "archived": false,
      "favorite": false,
      "trash": false,
      "reminder": null,
      "createdAt": DateTime.now().subtract(const Duration(hours: 5)),
    },
  ];

  /// CONTROLLERS
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final reminderController = TextEditingController(); 

  /// ADD NOTE
  void addNote() {
    setState(() {
      notes.add({
        "title": titleController.text,
        "desc": descController.text,
        "color": Colors.deepPurple,
        "icon": Icons.note,
        "archived": false,
        "favorite": false,
        "trash": false,
        "reminder": reminderController.text.trim().isEmpty ? null : reminderController.text,
        "createdAt": DateTime.now(),
      });
    });

    clearControllers();
    Navigator.pop(context);
  }

  /// EDIT NOTE
  void editNote(int index) {
    setState(() {
      notes[index]["title"] = titleController.text;
      notes[index]["desc"] = descController.text;
      notes[index]["reminder"] = reminderController.text.trim().isEmpty ? null : reminderController.text;
    });

    clearControllers();
    Navigator.pop(context);
  }

  /// TOGGLE TRASH (Soft Delete / Restore)
  void toggleTrash(int index) {
    setState(() {
      notes[index]["trash"] = !notes[index]["trash"];
      // If moving to trash, un-archive it so it doesn't get lost contextually
      if (notes[index]["trash"]) notes[index]["archived"] = false;
    });
  }

  /// PERMANENTLY DELETE NOTE
  void permanentDeleteNote(int index) {
    setState(() {
      notes.removeAt(index);
    });
  }

  /// TOGGLE FAVORITE
  void toggleFavorite(int index) {
    setState(() {
      notes[index]["favorite"] = !notes[index]["favorite"];
    });
  }

  /// TOGGLE ARCHIVE (Archive / Unarchive)
  void toggleArchive(int index) {
    setState(() {
      notes[index]["archived"] = !notes[index]["archived"];
    });
  }

  void clearControllers() {
    titleController.clear();
    descController.clear();
    reminderController.clear();
  }

  /// MODAL
  void showNoteDialog({int? index}) {
    if (index != null) {
      titleController.text = notes[index]["title"];
      descController.text = notes[index]["desc"];
      reminderController.text = notes[index]["reminder"] ?? "";
    } else {
      clearControllers();
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: isDarkMode ? const Color(0xff111827) : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            index == null ? "New Note" : "Edit Note",
            style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: isDarkMode ? const Color(0xff1F2937) : Colors.grey.shade200,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: descController,
                maxLines: 3,
                style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                decoration: InputDecoration(
                  hintText: "Description",
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: isDarkMode ? const Color(0xff1F2937) : Colors.grey.shade200,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: reminderController,
                style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                decoration: InputDecoration(
                  hintText: "Add Reminder (e.g., Today, 6 PM)",
                  prefixIcon: const Icon(Icons.notifications_none, color: Colors.grey),
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: isDarkMode ? const Color(0xff1F2937) : Colors.grey.shade200,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: isDarkMode ? Colors.white70 : Colors.black54),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(174, 93, 0, 255),
              ),
              onPressed: () {
                if (index == null) {
                  addNote();
                } else {
                  editNote(index);
                }
              },
              child: Text(index == null ? "Create" : "Update"),
            ),
          ],
        );
      },
    );
  }

  /// FILTER AND GET VISIBLE NOTES
  List<Map<String, dynamic>> getFilteredNotes() {
    switch (currentView) {
      case SelectedView.favorites:
        return notes.where((n) => n["favorite"] == true && n["trash"] == false && n["archived"] == false).toList();
      case SelectedView.recent:
        List<Map<String, dynamic>> recent = notes.where((n) => n["trash"] == false && n["archived"] == false).toList();
        recent.sort((a, b) => (b["createdAt"] as DateTime).compareTo(a["createdAt"] as DateTime));
        return recent;
      case SelectedView.reminders:
        return notes.where((n) => n["reminder"] != null && n["trash"] == false && n["archived"] == false).toList();
      case SelectedView.archive:
        return notes.where((n) => n["archived"] == true && n["trash"] == false).toList();
      case SelectedView.trash:
        return notes.where((n) => n["trash"] == true).toList();
      case SelectedView.all:
      default:
        return notes.where((n) => n["archived"] == false && n["trash"] == false).toList();
    }
  }

  String getViewTitle() {
    switch (currentView) {
      case SelectedView.favorites: return "Favorite Notes";
      case SelectedView.recent: return "Recent Notes";
      case SelectedView.reminders: return "Reminders";
      case SelectedView.archive: return "Archived Notes";
      case SelectedView.trash: return "Trash / Deleted";
      case SelectedView.all: default: return "All Notes";
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredNotes = getFilteredNotes();

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xff070B14) : Colors.grey.shade100,
      body: Row(
        children: [
          /// SIDEBAR
          Container(
            width: 250,
            color: isDarkMode ? const Color(0xff0B1020) : Colors.white,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.deepPurple,
                      child: Icon(Icons.note, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "Smart Notes",
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),

                /// NEW NOTE BUTTON
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => showNoteDialog(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.deepPurple, Color(0xff7C4DFF)],
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
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 35),

                /// MENU ITEMS WITH NAVIGATION FUNCTIONALITY
                menuItem(Icons.grid_view_rounded, "All Notes", currentView == SelectedView.all, () {
                  setState(() => currentView = SelectedView.all);
                }),
                menuItem(Icons.favorite_border, "Favorites", currentView == SelectedView.favorites, () {
                  setState(() => currentView = SelectedView.favorites);
                }),
                menuItem(Icons.access_time, "Recent", currentView == SelectedView.recent, () {
                  setState(() => currentView = SelectedView.recent);
                }),
                menuItem(Icons.notifications_none, "Reminders", currentView == SelectedView.reminders, () {
                  setState(() => currentView = SelectedView.reminders);
                }),
                menuItem(Icons.archive_outlined, "Archive", currentView == SelectedView.archive, () {
                  setState(() => currentView = SelectedView.archive);
                }),
                menuItem(Icons.delete_outline, "Trash", currentView == SelectedView.trash, () {
                  setState(() => currentView = SelectedView.trash);
                }),

                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xff5B21B6), Color(0xff7C3AED)]),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Upgrade Pro ✨",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Unlock premium features and cloud sync.",
                        style: TextStyle(color: Colors.white70),
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
                            color: isDarkMode ? const Color(0xff111827) : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.search, color: Colors.grey),
                              const SizedBox(width: 10),
                              Text(
                                "Search notes, tags or anything...",
                                style: TextStyle(
                                  color: isDarkMode ? Colors.grey : Colors.black54,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),

                      /// THEME BUTTON
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isDarkMode = !isDarkMode;
                            });
                          },
                          child: CircleAvatar(
                            radius: 24,
                            backgroundColor: isDarkMode ? const Color(0xff111827) : Colors.white,
                            child: Icon(
                              isDarkMode ? Icons.light_mode : Icons.dark_mode,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      const CircleAvatar(
                        radius: 24,
                        backgroundColor: Color(0xff111827),
                        child: Icon(Icons.notifications_none, color: Colors.white),
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
                    height: 160,
                    width: double.infinity,
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                        colors: [Color(0xff111827), Color(0xff312E81)],
                      ),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Your Ideas, Organized 🚀",
                          style: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Manage tasks, notes and projects in one premium workspace.",
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  /// SECTION TITLE DYNAMICALLY UPDATED
                  Text(
                    getViewTitle(),
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// NOTES GRID
                  Expanded(
                    child: filteredNotes.isEmpty
                        ? Center(
                            child: Text(
                              "No notes found here.",
                              style: TextStyle(color: isDarkMode ? Colors.white54 : Colors.black54, fontSize: 18),
                            ),
                          )
                        : GridView.builder(
                            itemCount: filteredNotes.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                              childAspectRatio: 1.1,
                            ),
                            itemBuilder: (context, index) {
                              final note = filteredNotes[index];
                              final realIndex = notes.indexOf(note);

                              return NoteCard(
                                title: note["title"],
                                desc: note["desc"],
                                color: note["color"],
                                icon: note["icon"],
                                isFavorite: note["favorite"],
                                isTrashView: note["trash"],
                                isArchived: note["archived"] ?? false,
                                reminder: note["reminder"],
                                onEdit: () => showNoteDialog(index: realIndex),
                                onDelete: () {
                                  if (note["trash"]) {
                                    permanentDeleteNote(realIndex);
                                  } else {
                                    toggleTrash(realIndex);
                                  }
                                },
                                onArchive: () => toggleArchive(realIndex),
                                onToggleFavorite: () => toggleFavorite(realIndex),
                                onRestore: () => toggleTrash(realIndex),
                              );
                            },
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

  Widget menuItem(IconData icon, String title, bool active, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          decoration: BoxDecoration(
            color: active ? Colors.deepPurple.withOpacity(0.25) : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: active
                    ? Colors.deepPurpleAccent
                    : (isDarkMode ? Colors.white70 : Colors.black54),
              ),
              const SizedBox(width: 15),
              Text(
                title,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: 16,
                  fontWeight: active ? FontWeight.bold : FontWeight.normal,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  final String title;
  final String desc;
  final Color color;
  final IconData icon;
  final bool isFavorite;
  final bool isTrashView;
  final bool isArchived;
  final String? reminder;

  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onArchive;
  final VoidCallback onToggleFavorite;
  final VoidCallback onRestore;

  const NoteCard({
    super.key,
    required this.title,
    required this.desc,
    required this.color,
    required this.icon,
    required this.isFavorite,
    required this.isTrashView,
    required this.isArchived,
    this.reminder,
    required this.onEdit,
    required this.onDelete,
    required this.onArchive,
    required this.onToggleFavorite,
    required this.onRestore,
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
              Row(
                children: [
                  if (isFavorite && !isTrashView)
                    const Icon(Icons.favorite, color: Colors.redAccent, size: 20),
                  PopupMenuButton<String>(
                    color: const Color(0xff111827),
                    icon: const Icon(Icons.more_vert, color: Colors.white70),
                    onSelected: (value) {
                      switch (value) {
                        case "edit": onEdit(); break;
                        case "archive": onArchive(); break;
                        case "favorite": onToggleFavorite(); break;
                        case "delete": onDelete(); break;
                        case "restore": onRestore(); break;
                      }
                    },
                    itemBuilder: (context) => [
                      if (!isTrashView) ...[
                        const PopupMenuItem(value: "edit", child: Text("Edit", style: TextStyle(color: Colors.white))),
                        PopupMenuItem(
                          value: "archive", 
                          child: Text(isArchived ? "Unarchive" : "Archive", style: const TextStyle(color: Colors.white)),
                        ),
                        PopupMenuItem(
                          value: "favorite",
                          child: Text(isFavorite ? "Unfavorite" : "Favorite", style: const TextStyle(color: Colors.white)),
                        ),
                        const PopupMenuItem(value: "delete", child: Text("Move to Trash", style: TextStyle(color: Colors.white))),
                      ] else ...[
                        const PopupMenuItem(value: "restore", child: Text("Restore Note", style: TextStyle(color: Colors.white))),
                        const PopupMenuItem(value: "delete", child: Text("Delete Permanently", style: TextStyle(color: Colors.redAccent))),
                      ]
                    ],
                  ),
                ],
              )
            ],
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            desc,
            style: const TextStyle(color: Colors.white70, fontSize: 15),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (reminder != null && !isTrashView) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.access_time, color: Colors.white, size: 14),
                  const SizedBox(width: 6),
                  Text(
                    reminder!,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            )
          ]
        ],
      ),
    );
  }
}