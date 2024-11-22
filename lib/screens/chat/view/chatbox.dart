import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:merc_mania/common/widgets/styled_app_bar.dart';
import 'package:merc_mania/core/configs/assets/app_format.dart';
import 'package:merc_mania/screens/chat/cubit/chat_cubit.dart';
import 'package:merc_mania/services/models/message.dart';

import '../../../core/configs/themes/app_colors.dart';

class Chatbox extends StatefulWidget {
  final User receiver;
  const Chatbox({super.key, required this.receiver});

  @override
  State<Chatbox> createState() => _ChatboxState();
}

class _ChatboxState extends State<Chatbox> {
  final controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  void scrollToBottom() {
    scrollController.animateTo(
    scrollController.position.maxScrollExtent,
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: StyledAppBar(
          title: Text('${widget.receiver.firstName} ${widget.receiver.lastName}'),
        ),
        body: Column(children: [
          Expanded(
            child: Padding(padding: EdgeInsets.all(8),
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream:  context.read<ChatCubit>().fetchMessage(widget.receiver.id), 
                builder: (builder, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
                  if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                  if (snapshot.hasData) {
                    final messages = snapshot.data!.docs.map((doc) => Message.fromJson(doc.data())).toList();
                    return ListView.builder(
                      controller: scrollController,
                      itemCount: messages.length,
                      itemBuilder: (context, index) => Padding(padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: messages[index].senderId != widget.receiver.id 
                                            ? MainAxisAlignment.end 
                                            : MainAxisAlignment.start,
                          children: [
                            Container(padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(123, 247, 242, 255),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  messages[index].contentType=='text' 
                                  ? Text(messages[index].content) 
                                  : Image.network(messages[index].content, width: 150, height: 150, fit: BoxFit.cover),
                                  Row(
                                    children: [
                                      Text(
                                          AppFormat.hourmin.format(AppFormat.euDate.parse(messages[index].timestamp)),
                                          style: TextStyle(fontSize: 10),
                                          ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],                     
                        ),
                      )
                    );
                  }                                    
                  return Text('No data found');    
                }
              ),
            ),
          ),
          Align(
            child: Padding(padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () { context.read<ChatCubit>().selectImage(widget.receiver.id);  setState(() { scrollToBottom(); });}, 
                    icon: Icon(FontAwesomeIcons.images, color: AppColors.primary)),
                    IconButton(
                    onPressed: () {}, 
                    icon: Icon(FontAwesomeIcons.solidFaceLaughBeam, color: AppColors.primary)),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      textInputAction: TextInputAction.newline,
                      textCapitalization: TextCapitalization.sentences,
                      controller: controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide(color: AppColors.primary), borderRadius: BorderRadius.circular(20)),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.primary), borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.primary), borderRadius: BorderRadius.circular(20)),
                        hintText: 'Type your message...',
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<ChatCubit>().sendMessage(widget.receiver.id, controller.text);
                      setState(() { controller.clear(); scrollToBottom(); });
                    },
                    icon: Icon(Icons.send, color: AppColors.primary))
                        ]),
            ))
        ])
    );
  }
}