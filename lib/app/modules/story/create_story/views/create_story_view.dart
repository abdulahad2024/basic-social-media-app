import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/create_story_controller.dart';

class CreateStoryView extends GetView<CreateStoryController> {
  const CreateStoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Story'),
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: controller.selectedFile.value == null
                      ? const Center(child: Text("No file selected"))
                      : controller.fileType.value == 'image'
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.file(controller.selectedFile.value!, fit: BoxFit.cover),
                  )
                      : const Center(child: Icon(Icons.video_library, size: 100, color: Colors.blue)),
                ),
              ),
              const SizedBox(height: 20),

              // বাটনসমূহ
              if (controller.isLoading.value)
                const CircularProgressIndicator()
              else ...[
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => controller.pickFile(false),
                        icon: const Icon(Icons.image),
                        label: const Text("Image"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => controller.pickFile(true),
                        icon: const Icon(Icons.videocam),
                        label: const Text("Video"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                    onPressed: controller.selectedFile.value == null ? null : () => controller.uploadStory(),
                    child: const Text("Upload Story"),
                  ),
                ),
              ]
            ],
          ),
        );
      }),
    );
  }
}