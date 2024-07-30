import 'package:assessment_swavalambanam/features/newspaper/presentation/bloc/newspaper_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';

class NewspaperPage extends StatefulWidget {
  const NewspaperPage({super.key});

  @override
  State<NewspaperPage> createState() => _NewspaperPageState();
}

class _NewspaperPageState extends State<NewspaperPage> {
  final FlutterTts flutterTts = FlutterTts();

//handles Text to speech
  Future<void> _speak(
    String text,
  ) async {
    await flutterTts.setSharedInstance(true);
    await flutterTts.setIosAudioCategory(
        IosTextToSpeechAudioCategory.ambient,
        [
          IosTextToSpeechAudioCategoryOptions.allowBluetooth,
          IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
          IosTextToSpeechAudioCategoryOptions.mixWithOthers
        ],
        IosTextToSpeechAudioMode.voicePrompt);
    await flutterTts.setLanguage("en-IN");
    await flutterTts.setPitch(1.0);
    await flutterTts.setVolume(1.0);
    await flutterTts.speak(text);
  }

  @override
  void initState() {
    context.read<NewspaperBloc>().add(const GetNewspaperList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text('Newspapers'),
        bottom: const PreferredSize(preferredSize: Size.fromHeight(0),child: Divider(),),
      ),
      body: BlocConsumer<NewspaperBloc, NewspaperState>(
        listener: (context, state) {
          //shows snackbar if some error in fetching data
          if (state is NewspaperErrorState) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is NewspaperInitial) {
            return const Center(child: Text('Loading...'));
          } else if (state is NewspaperLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NewspaperLoaded) {
            return ListView.builder(
              itemCount: state.newspapers.length,
              itemBuilder: (context, index) {
                final newspaper = state.newspapers[index];
                return Card(
                  margin: const EdgeInsets.all(15),
                  color: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Text(
                                "Title : ${newspaper.title}",
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Expanded(
                              //plays news data
                              child: IconButton(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onPressed: () async {
                                  _speak(
                                    'Title: ${newspaper.title}, Published in: ${newspaper.placeOfPublication}, From ${newspaper.startYear} to ${newspaper.endYear}. Publisher: ${newspaper.publisher}.',
                                  );
                                },
                                icon: const Icon(
                                  Icons.play_arrow,
                                ),
                              ),
                            )
                          ],
                        ),
                        Text(
                            'Published In : ${newspaper.placeOfPublication} (${newspaper.startYear} - ${newspaper.endYear})'),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Publisher: ${newspaper.publisher}"),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("LCCN: ${newspaper.lccn}'"),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
