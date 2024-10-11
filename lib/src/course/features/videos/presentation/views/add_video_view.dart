import 'package:education_app/core/common/widgets/course_picker.dart';
import 'package:education_app/core/common/widgets/info_field.dart';
import 'package:education_app/core/extensions/string_extensions.dart';
import 'package:education_app/src/course/domain/entities/course.dart';
import 'package:education_app/src/course/features/videos/data/models/video_model.dart';
import 'package:education_app/src/course/features/videos/presentation/utils/video_utils.dart';
import 'package:flutter/material.dart';

class AddVideoView extends StatefulWidget {
  const AddVideoView({super.key});

  static const routeName = '/add-video';

  @override
  State<AddVideoView> createState() => _AddVideoViewState();
}

class _AddVideoViewState extends State<AddVideoView> {
  final urlController = TextEditingController();
  final authorController = TextEditingController(text: 'wojtek');
  final titleController = TextEditingController();
  final courseController = TextEditingController();
  final courseNotifier = ValueNotifier<Course?>(null);

  final formKey = GlobalKey<FormState>();

  VideoModel? video;

  final authorFocusNode = FocusNode();
  final titleFocusNode = FocusNode();
  final urlFocusNode = FocusNode();

  bool getMoreDetails = false;

  bool get isYouTube => urlController.text.trim().isYouTubeVideo;

  bool thumbNailIsFile = false;

  bool loading = false;

  void reset() {
    setState(() {
      urlController.clear();
      authorController.text = 'wojtek';
      titleController.clear();
      getMoreDetails = false;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    urlController.addListener(() {
      if (urlController.text.trim().isEmpty) reset();
    });
  }

  Future<void> fetchVideo() async {
    if (urlController.text.trim().isEmpty) return;
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      getMoreDetails = false;
      loading = false;
      thumbNailIsFile = false;
      video = null;
    });
    if (isYouTube) {
      setState(() {
        loading = true;
      });

      video = await VideoUtils.getVideoFromYT(
        context,
        url: urlController.text.trim(),
      ) as VideoModel?;
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void dispose() {
    urlController.dispose();
    authorController.dispose();
    titleController.dispose();
    courseController.dispose();
    courseNotifier.dispose();
    urlFocusNode.dispose();
    titleFocusNode.dispose();
    authorFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Add Video'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        shrinkWrap: true,
        children: [
          Form(
            key: formKey,
            child: CoursePicker(
              controller: courseController,
              notifier: courseNotifier,
            ),
          ),
          const SizedBox(height: 20),
          InfoField(
            controller: urlController,
            hintText: 'Enter video URL',
            onEditingComplete: fetchVideo,
            focusNode: urlFocusNode,
            onTapOutside: (_) => urlFocusNode.unfocus(),
            autoFocus: true,
            keyboardType: TextInputType.url,
          ),
          ListenableBuilder(
            listenable: urlController,
            builder: (_, __) {
              return Column(
                children: [
                  if (urlController.text.trim().isNotEmpty) ...[
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: fetchVideo,
                      child: const Text('Fetch Video'),
                    ),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
