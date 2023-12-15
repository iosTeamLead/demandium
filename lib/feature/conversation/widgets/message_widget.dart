import 'dart:isolate';
import 'dart:ui';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:demandium/components/core_export.dart';
import 'package:demandium/feature/conversation/widgets/image_dialog.dart';
import 'package:path_provider/path_provider.dart';


class ConversationBubble extends StatefulWidget {
  final ConversationData conversationData;
  final bool isRightMessage;
  final String oppositeName;
  final String oppositeImage;

  const ConversationBubble({super.key, required this.conversationData, required this.isRightMessage, required this.oppositeName,required this.oppositeImage});

  @override
  State<ConversationBubble> createState() => _ConversationBubbleState();
}

class _ConversationBubbleState extends State<ConversationBubble> {

  @override
  void initState() {
    super.initState();
    if(!ResponsiveHelper.isWeb() && ResponsiveHelper.isMobile(Get.context)){
      ReceivePort port = ReceivePort();
      IsolateNameServer.registerPortWithName(port.sendPort, 'downloader_send_port');
      port.listen((dynamic data) {
        setState((){ });
      });

      //FlutterDownloader.registerCallback(downloadCallback);
    }

  }

  @override
  void dispose() {
    if(!ResponsiveHelper.isWeb() && ResponsiveHelper.isMobile(Get.context)){
      IsolateNameServer.removePortNameMapping('downloader_send_port');
    }
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }


  @override
  Widget build(BuildContext context) {

    String imagePath = widget.conversationData.user!.userType=="customer"?"/user/profile_image/"
        :widget.conversationData.user!.userType=="provider-admin"?"/provider/logo/"
        :widget.conversationData.user!.userType=="super-admin"?"/user/profile_image/"
        :widget.conversationData.user!.userType=="provider-serviceman"?"/serviceman/profile/":"";
    String image = '';

    if(widget.conversationData.user!.provider != null){
      image = '${Get.find<SplashController>().configModel.content!.imageBaseUrl}''$imagePath${widget.conversationData.user!.provider!.logo!}';
    }else{
      image = '${Get.find<SplashController>().configModel.content!.imageBaseUrl}''$imagePath${widget.conversationData.user!.profileImage!}';
    }

    return Column(
      crossAxisAlignment: widget.isRightMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: widget.isRightMessage
              ? const EdgeInsets.fromLTRB(20, 5, 5, 5)
              : const EdgeInsets.fromLTRB(5, 5, 20, 5),
          child: Column(
            crossAxisAlignment:
            widget.isRightMessage ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              //Name
              widget.conversationData.user!=null?Row(
                mainAxisAlignment: widget.isRightMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  Text(widget.isRightMessage ?'${Get.find<UserController>().userInfoModel.fName!} ${Get.find<UserController>().userInfoModel.lName}' :widget.oppositeName ),
                ],
              ):const SizedBox(),
              Gaps.verticalGapOf(Dimensions.fontSizeExtraSmall),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: widget.isRightMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  //Avater for Right
                  widget.isRightMessage
                      ? const SizedBox()
                      : Column(children: [
                    ClipRRect(borderRadius: BorderRadius.circular(50),
                        child: CustomImage(height: 30, width: 30,
                            image: widget.oppositeImage)),
                  ],
                  ),
                  const SizedBox(width: Dimensions.paddingSizeSmall,),
                  //Message body
                  Flexible(
                    child: Column(
                      crossAxisAlignment: widget.isRightMessage?CrossAxisAlignment.end:CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if(widget.conversationData.message != null) Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).hoverColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(widget.conversationData.message != null?Dimensions.paddingSizeDefault:0),
                              child: Text(widget.conversationData.message??''),
                            ),
                          ),
                        ),
                        if( widget.conversationData.conversationFile!.isNotEmpty) const SizedBox(height: Dimensions.paddingSizeSmall),
                        widget.conversationData.conversationFile!.isNotEmpty?
                        Directionality(
                          textDirection:Get.find<LocalizationController>().isLtr ? widget.isRightMessage ? TextDirection.rtl: TextDirection.ltr : widget.isRightMessage ?TextDirection.ltr : TextDirection.rtl,
                          child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 1,
                                crossAxisCount: ResponsiveHelper.isDesktop(context)?5:ResponsiveHelper.isTab(context)?4:3,
                                mainAxisSpacing: Dimensions.paddingSizeSmall,
                                crossAxisSpacing: Dimensions.paddingSizeSmall,
                            ),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.conversationData.conversationFile!.length,
                            itemBuilder: (BuildContext context, index){
                              return widget.conversationData.conversationFile![index].fileType == 'png' || widget.conversationData.conversationFile![index].fileType == 'jpg'?
                              InkWell(
                                onTap: () => showDialog(context: context, builder: (ctx)  =>  ImageDialog(imageUrl: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}/conversation/${widget.conversationData.conversationFile![index].fileName ?? ''}'), ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child:
                                  FadeInImage.assetNetwork(
                                    placeholder: Images.placeholder, height: 100, width: 100, fit: BoxFit.cover,
                                    image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl}/conversation/${widget.conversationData.conversationFile![index].fileName ?? ''}',
                                    imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, height: 100, width: 100, fit: BoxFit.cover),
                                  ),
                                ),
                              ) :
                              InkWell(
                                onTap : () async {
                                  if(ResponsiveHelper.isMobile(context)){
                                    final status = await Permission.storage.request();
                                    if(status.isGranted){
                                      Directory? directory = Directory('/storage/emulated/0/Download');
                                      if (!await directory.exists()) {
                                        directory = Platform.isAndroid
                                          ? await getExternalStorageDirectory() //FOR ANDROID
                                          : await getApplicationSupportDirectory();
                                      }
                                      Get.find<ConversationController>().downloadFile('${Get.find<SplashController>().configModel.content!.imageBaseUrl}/conversation/${widget.conversationData.conversationFile![index].fileName ?? ''}',directory!.path);
                                    }else{
                                    }
                                  }else{
                                    Get.find<ConversationController>().downloadFileForWeb('${Get.find<SplashController>().configModel.content!.imageBaseUrl}/conversation/${widget.conversationData.conversationFile![index].fileName ?? ''}');
                                  }
                                },
                                child: Container(height: 50,width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Theme.of(context).hoverColor
                                  ),
                                  child: Stack(
                                    children: [
                                      Center(child: SizedBox(width: 50, child: Image.asset(Images.folder))),
                                      Center(
                                        child: Text('${widget.conversationData.conversationFile![index].fileName}'.substring(widget.conversationData.conversationFile![index].fileName!.length-7),
                                          maxLines: 5, overflow: TextOverflow.clip,),
                                      ),
                                    ],
                                  ),),
                              );
                            },),
                        ):
                        const SizedBox.shrink(),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10,),
                  widget.isRightMessage ?
                  ClipRRect(borderRadius: BorderRadius.circular(50),
                      child: CustomImage(height: 30, width: 30,
                          image: image))

                      : const SizedBox(),
                ],
              ),
              Gaps.verticalGapOf(Dimensions.paddingSizeExtraSmall),

            ],
          ),
        ),
        Padding(
            padding:Get.find<LocalizationController>().isLtr ?  widget.isRightMessage ? const EdgeInsets.fromLTRB(5, 5, 50, 5) : const EdgeInsets.fromLTRB(50, 5, 5, 5):
            const EdgeInsets.fromLTRB(50, 5, 5, 5),
            child: Text(
                DateConverter.dateMonthYearTimeTwentyFourFormat(DateConverter.isoUtcStringToLocalDate(widget.conversationData.createdAt!)),
                style: const TextStyle(fontSize: 8.0),
                textDirection: TextDirection.ltr)
        ),

      ],
    );
  }
}
