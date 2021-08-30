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
  final NoticeModel? noticeModel;
  AddNoticeScreen({Key? key, this.noticeModel}) : super(key: key);

  @override
  State<AddNoticeScreen> createState() => _AddNoticeScreenState();
}

class _AddNoticeScreenState extends State<AddNoticeScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController decribtionController = TextEditingController();

  final fromKey = GlobalKey<FormState>();
  bool isEdit = false;
  File? selectedFile;
  final border = OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(10)));

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      if (result.files.single.size < 10000000) {
        selectedFile = File(result.files.single.path!);
        setState(() {});
      } else {
        Methods.showToast(
            toastMessage: 'File size is too large.',
            duration: Toast.LENGTH_LONG);
      }
    } else {
      Methods.showToast(
          toastMessage: 'No file selected.', duration: Toast.LENGTH_LONG);
    }
  }

  void removeFile() {
    selectedFile = null;
    setState(() {});
  }

  void setFieldValues() {
    titleController.text = widget.noticeModel?.title ?? '';
    decribtionController.text = widget.noticeModel?.describtion ?? '';
    isEdit = true;
  }

  @override
  void initState() {
    super.initState();
    if (widget.noticeModel != null) {
      setFieldValues();
    }
  }

  @override
  void dispose() {
    super.dispose();
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
                        buttonText:
                            isEdit ? 'Update notice' : 'Post the notice',
                        onPressed: storageProvider.isLoading
                            ? null
                            : () {
                                if (fromKey.currentState!.validate()) {
                                  print('Form is valid');

                                  Methods.showUploadLoading(
                                      context: context, workTodo: setNotice());
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

  Future<void> setNotice() async {
    String noticeId = DateTime.now().toString();
    var storageProvider = Provider.of<StorageState>(context, listen: false);
    if (selectedFile != null) {
      await storageProvider.uploadFile(
          fileToUpload: selectedFile!, fileName: noticeId);
    }
    NoticeModel noticeModel = NoticeModel(
        title: titleController.text,
        describtion: decribtionController.text,
        noticeId: noticeId,
        attachmentLink: storageProvider.imageUrlLink ?? 'No');
    if (isEdit) {
      print(noticeModel.noticeId);
      await services<FirestoreRepos>()
          .updateNotice(noticeModel)
          .timeout(Duration(seconds: 3))
          .then((value) {
        clearAllData();
        Methods.showToast(toastMessage: 'Upadated Successfully');
        Navigator.pop(context);
      }).catchError((error, stackTrace) {
        Methods.showToast(toastMessage: '$error');
      });
    } else {
      await services<FirestoreRepos>()
          .addANotice(noticeModel)
          .timeout(Duration(seconds: 3))
          .then((value) {
        clearAllData();
        Methods.showToast(toastMessage: 'Added Successfully');
        Navigator.pop(context);
      }).catchError((error, stackTrace) {
        Methods.showToast(toastMessage: '$error');
      });
    }
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
