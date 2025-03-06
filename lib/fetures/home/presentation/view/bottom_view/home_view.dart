import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:room_finder_app/fetures/room/presentation/view_model/room_get_my_room_view_model.dart';

import '../../../../../core/common/text/room_finder_style_text.dart';
import '../../../../../core/common/text/text.dart';
import '../../../../room/domain/entity/room_entity.dart';
import '../../../../room/presentation/view_model/room_viewmodel.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    ref.watch(roomGetMyRoomViewModelProvider);
    // ref.watch(roomViewModelProvider.notifier).getAllRooms();
    final roomState = ref.watch(roomViewModelProvider);

    final List<RoomEntity> roomList = roomState.rooms;
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: width * 1,
                    height: height * 0.3,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(182, 39, 4, 0.938),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    child: const Align(
                      alignment: Alignment.topCenter,
                      child: StyleText(),
                    ),
                  ),
                  Positioned(
                    top: height * 0.1,
                    left: width * 0.11,
                    width: width * 0.8,
                    height: height * 0.24,
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.topCenter,
                            child: MakingText('Find a Hotel'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SizedBox(
                              width: width * 0.7,
                              child: Form(
                                child: Column(
                                  children: [
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromRGBO(
                                                182, 39, 4, 0.938),
                                            width: 2,
                                          ),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromRGBO(
                                                182, 39, 4, 0.938),
                                            width: 2,
                                          ),
                                        ),
                                        prefixIcon: Icon(
                                          Icons.location_on,
                                        ),
                                        hintText: 'Enter the Hotel Name',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.5,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text('Search'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.05,
              ),
              if (roomState.isLoading) ...{
                const Center(child: CircularProgressIndicator()),
              } else if (roomState.error != null) ...{
                Text(roomState.error.toString()),
              } else if (roomState.rooms.isEmpty) ...{
                const Center(child: Text('No Hotel Found')),
              } else ...{
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    // separatorBuilder: (context, index) =>
                    //     const SizedBox(height: 10),
                    itemCount: roomList.length,
                    itemBuilder: (context, index) {
                      RoomEntity room = roomList[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 12,
                        shadowColor: const Color.fromARGB(255, 211, 199, 199),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  FullScreenWidget(
                                    disposeLevel: DisposeLevel.Medium,
                                    child: SizedBox(
                                      width: width * 0.25,
                                      height: width * 0.35,
                                      child: room.image != null &&
                                              room.image!.isNotEmpty
                                          ? Image.network(
                                              'http://192.168.101.6:4000/uploads/${room.image}',
                                              fit: BoxFit.fill,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  Image.asset(
                                                'assets/images/i.jpg',
                                                fit: BoxFit.fill,
                                              ),
                                            )
                                          : Image.asset(
                                              'assets/images/i.jpg',
                                              fit: BoxFit.fill,
                                            ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          room.title,
                                          style: const TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: width * 0.3,
                                              child: ListTile(
                                                leading: const Icon(
                                                    Icons.currency_rupee),
                                                contentPadding:
                                                    const EdgeInsets.all(0),
                                                title: Transform(
                                                  transform:
                                                      Matrix4.translationValues(
                                                    -10,
                                                    0.0,
                                                    0.0,
                                                  ),
                                                  child: Text(
                                                    room.price.toString(),
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: width * 0.35,
                                              child: ListTile(
                                                leading: const Icon(Icons.call),
                                                contentPadding:
                                                    const EdgeInsets.all(0),
                                                title: Transform(
                                                  transform:
                                                      Matrix4.translationValues(
                                                    -10,
                                                    0.0,
                                                    0.0,
                                                  ),
                                                  child: Text(
                                                    room.phoneNumber.toString(),
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: width * 0.6,
                                          child: ListTile(
                                            leading:
                                                const Icon(Icons.location_on),
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            title: Transform(
                                              transform:
                                                  Matrix4.translationValues(
                                                -10,
                                                0.0,
                                                0.0,
                                              ),
                                              child: Text(
                                                room.location,
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.6,
                                          child: ListTile(
                                            leading:
                                                const Icon(Icons.description),
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            title: Transform(
                                              transform:
                                                  Matrix4.translationValues(
                                                -10,
                                                0.0,
                                                0.0,
                                              ),
                                              child: Text(
                                                room.description,
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              },
            ],
          ),
        ),
      ),
    );
  }
}
