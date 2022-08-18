import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_rick_morty/constants/colors.dart';
import 'package:test_rick_morty/models/character.dart';
import 'package:test_rick_morty/screens/details_screen/details_screen.dart';
import 'package:test_rick_morty/screens/main_screen/bloc/character_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageNumber = 1;
  List<Character> characters = [];
  ScrollController scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(pagination);
    context.read<CharacterBloc>().add(GetCharacters(pageNumber: pageNumber));
  }

  void pagination() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 100 &&
        !isLoading) {
      pageNumber++;
      context.read<CharacterBloc>().add(GetCharacters(pageNumber: pageNumber));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryDark,
      appBar: AppBar(
        backgroundColor: AppColor.primaryBlue,
        title: const Text(
          'Characters List',
          style: TextStyle(color: AppColor.primaryGreen),
        ),
      ),
      body: BlocBuilder<CharacterBloc, CharacterState>(builder: (context, state) {
        if (state is CharacterLoading) {
          isLoading = true;
        }
        if (state is CharactersGot) {
          isLoading = false;
          characters.addAll(state.characters);
        }
        if (state is CharacterError) {
          isLoading = false;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                state.errorMessage,
                style: const TextStyle(color: AppColor.primaryGreen),
              ),
            ],
          );
        }
        return SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: scrollController,
                  itemCount: characters.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailsScreen(character: characters[index])));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 9, horizontal: 16),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColor.primaryBlue,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                characters[index].image,
                                width: 100,
                                height: 100,
                              ),
                            ),
                            const SizedBox(width: 16,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          characters[index].name,
                                          style: const TextStyle(
                                            color: AppColor.primaryGreen,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 25,
                                        height: 25,
                                        child: genderIcon(characters[index].gender),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        characters[index].gender.name.toLowerCase(),
                                        style: const TextStyle(
                                          color: AppColor.primaryGreen,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: AppColor.primaryGreen,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              isLoading
                  ? const CupertinoActivityIndicator(
                      color: AppColor.primaryGreen,
                    )
                  : const SizedBox(),
            ],
          ),
        );
      }),
    );
  }
}

Widget genderIcon(Gender gender) {
  switch (gender) {
    case Gender.FEMALE:
      return SvgPicture.asset(
        "assets/icons/female.svg",
        color: AppColor.primaryGreen,
      );
    case Gender.MALE:
      return SvgPicture.asset(
        "assets/icons/male.svg",
        color: AppColor.primaryGreen,
      );
    case Gender.UNKNOWN:
      return SvgPicture.asset(
        "assets/icons/unknown.svg",
        color: AppColor.primaryGreen,
      );
  }
}
