import 'package:flutter/material.dart';
import 'package:test_rick_morty/models/character.dart';

import '../../constants/colors.dart';
import '../main_screen/main_screen.dart';

class DetailsScreen extends StatelessWidget {
  final Character character;

  const DetailsScreen({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryDark,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColor.primaryGreen,
          ),
        ),
        backgroundColor: AppColor.primaryBlue,
        title: Text(
          character.name,
          style: const TextStyle(color: AppColor.primaryGreen),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        character.image,
                        width: MediaQuery.of(context).size.width / 1.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                mainInfo(),
                Container(
                  height: 100,
                  margin: const EdgeInsets.symmetric(vertical: 9, horizontal: 16),
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: AppColor.primaryBlue,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Episodes:",
                          style: TextStyle(
                            color: AppColor.primaryGreen,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: character.episode.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 4,  horizontal: 2),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColor.primaryDark.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                character.episode[index].split('/').last,
                                style: const TextStyle(
                                  color: AppColor.primaryGreen,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget mainInfo() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 9, horizontal: 16),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.primaryBlue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text(
            "Info:",
            style: TextStyle(
              color: AppColor.primaryGreen,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Name:",
                style: TextStyle(
                  color: AppColor.primaryGreen,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                character.name,
                style: const TextStyle(
                  color: AppColor.primaryGreen,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Status:",
                style: TextStyle(
                  color: AppColor.primaryGreen,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                character.status.name.toLowerCase(),
                style: const TextStyle(
                  color: AppColor.primaryGreen,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Gender:",
                style: TextStyle(
                  color: AppColor.primaryGreen,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                width: 25,
                height: 25,
                child: genderIcon(character.gender),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
