import 'dart:ffi';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:madrasah_app/di_contailer.dart';
import 'package:madrasah_app/models/notice_model.dart';
import 'package:madrasah_app/state_management/storage_state.dart';
import 'package:madrasah_app/utils/firestore_repos/firestore_repos.dart';
import 'package:madrasah_app/utils/form_validation.dart';
import 'package:madrasah_app/utils/methods.dart';
import 'package:madrasah_app/views/shared_widgets/input_field.dart';
import 'package:madrasah_app/views/styles/dimentions.dart';
import 'package:madrasah_app/views/styles/styles.dart';
import 'package:provider/provider.dart';

class AddNoticeScreen extends StatefulWidget {
  AddNoticeScreen({Key? key}) : super(key: key);

  @override
  State<AddNoticeScreen> createState() => _AddNoticeScreenState();
}

class _AddNoticeScreenState extends State<AddNoticeScreen> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController decribtionController = TextEditingController();

  final fromKey = GlobalKey<FormState>();
  File? selectedFile;
  final border = OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(10)));

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null && result.files.single.size < 10000000) {
      selectedFile = File(result.files.single.path!);
      setState(() {});
    } else {
      Methods.showToast(
          toastMessage: 'File size is too large.', duration: Toast.LENGTH_LONG);
    }
  }

  void removeFile() {
    selectedFile = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var storageProvider = Provider.of<StorageState>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              // vertical: size(context).height * 0.1,
              right: size(context).width * 0.1,
              left: size(context).width * 0.1,
              top: size(context).width * 0.1),
          child: SingleChildScrollView(
            child: Form(
              key: fromKey,
              child: Column(
                children: [
                  InputField(
                    hintText: 'Enter notice title here',
                    validator: FormValidation.validateNoticeTitle,
                    textEditingController: titleController,
                    maxLength: 30,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: decribtionController,
                    maxLines: 4,
                    cursorColor: CResources.black,
                    style: TextStyle(
                        color: CResources.black, fontFamily: Fonts.openSans),
                    decoration: InputDecoration(
                        hintText: 'Enter notice desctribtion(Optional)',
                        enabledBorder: border,
                        focusedBorder: border,
                        errorBorder: border,
                        focusedErrorBorder: border,
                        hintStyle: TextStyle(
                          color: CResources.black,
                        ),
                        fillColor: CResources.black.withOpacity(0.1),
                        filled: true),
                  ),
                  GestureDetector(
                    onTap: selectedFile == null
                        ? () async {
                            pickFile();
                          }
                        : null,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 30),
                      height: size(context).height * 0.3,
                      width: double.infinity,
                      child: selectedFile == null
                          ? Center(
                              child: Text(
                              'Click here to attach some files',
                              style: TextStyle(fontFamily: Fonts.monserrat),
                            ))
                          : AttachedFileList(
                              attachedFile: selectedFile!,
                              onPressed: removeFile,
                            ),
                      decoration: BoxDecoration(
                          color: CResources.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                  // storageProvider.upLoadPersent != 100.0 &&
                  storageProvider.isLoading
                      ? Text(
                          'Uploading ${storageProvider.upLoadPersent}%, don\'t close the window')
                      : Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Button(
                          onPressed: () {
                            clearAllData();
                            Navigator.pop(context);
                          },
                          buttonText: 'Back'),
                      Button(
                        buttonText: 'Post the notice',
                        onPressed: storageProvider.isLoading
                            ? null
                            : () {
                                if (fromKey.currentState!.validate()) {
                                  print('Form is valid');
                                  if (selectedFile != null) {
                                    Methods.showUploadLoading(
                                        context: context,
                                        workTodo: postTheNotice(selectedFile!));
                                    // storageProviderMuted.uploadMultipleFile(
                                    //     attachFileState.attachedFiles);
                                  }
                                }
                              },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> postTheNotice(File fileToUpload) async {
    String noticeId = DateTime.now().toString();
    var storageProvider = Provider.of<StorageState>(context, listen: false);
    await storageProvider.uploadFile(
        fileToUpload: selectedFile!, fileName: noticeId);
    NoticeModel noticeModel = NoticeModel(
        title: titleController.text,
        describtion: decribtionController.text,
        noticeId: noticeId,
        attachmentLink: storageProvider.imageUrlLink);
    clearAllData();
    await services<FirestoreRepos>().addANotice(noticeModel);
  }

  void clearAllData() {
    titleController.clear();
    decribtionController.clear();
    removeFile();
  }
}

class Button extends StatelessWidget {
  final void Function()? onPressed;
  final String buttonText;
  const Button({Key? key, required this.onPressed, required this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30),
      child: MaterialButton(
        onPressed: onPressed,
        color: CResources.blue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Text(
          buttonText,
          style: TextStyle(color: CResources.white),
        ),
      ),
    );
  }
}

class AttachedFileList extends StatelessWidget {
  final File attachedFile;
  final void Function()? onPressed;
  const AttachedFileList(
      {Key? key, required this.attachedFile, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ListTile(
      title: Text(attachedFile.path),
      trailing: IconButton(
        onPressed: onPressed,
        icon: Icon(Icons.delete),
      ),
    ));
  }
}
