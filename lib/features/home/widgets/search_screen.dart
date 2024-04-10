import 'package:avrod/Widgets/nodata_screen.dart';
import 'package:avrod/Widgets/text_widget.dart';
import 'package:avrod/cubits/searchCubit/search_cubit.dart';
import 'package:avrod/features/personal-page/screens/personal_page_screen.dart';
import 'package:avrod/models/user_model.dart';
import 'package:avrod/services/firebase_post.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    context.read<SearchCubit>().searchUser('');
    super.initState();
  }
  final TextEditingController searchController =TextEditingController();
bool reqSent = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 8),
                          child: const Icon(Icons.arrow_back,weight: 10,),

                      ),
                    ),
                    const SizedBox(width: 12,),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          showCursor: true,
                          cursorColor: Colors.blue,
                          // cursorHeight: 30,
                          cursorWidth: 2,
                          textAlignVertical: TextAlignVertical.center,
                          onChanged: (val){
                            context.read<SearchCubit>().searchUser(searchController.text);
                          },
                          controller: searchController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 4),
                            hintText: 'Search...',

                            // Add a clear button to the search bar
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.clear,color: Colors.black,),
                              onPressed: ()  {
                                searchController.clear();
                                context.read<SearchCubit>().searchUser('');
                              },
                            ),
                            // Add a search icon or button to the search bar
                            prefixIcon: const Icon(Icons.search,color: Colors.black,),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Expanded(
                  child: BlocBuilder<SearchCubit,SearchState>(
                      builder: (_,state){
                        List<UserModel> users=[];
                        if(state is SearchSuccess) {
                          users = state.props.first as List<UserModel>;
                          return (users.isEmpty) ?
                          const NoDataWidget()
                              : Container(
                            // height: 500,
                            child: ListView.builder(
                                itemCount: users.length,
                                itemBuilder: (_, index) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            PersonalPageScreen.routeName,
                                            arguments: users[index].userId,
                                          );
                                        },
                                        title: Text_Widget(users[index].name),
                                        leading: Container(
                                          height: 50,
                                          width: 50,
                                          clipBehavior: Clip.hardEdge,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                  25)
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: users[index].photo ?? '',
                                            progressIndicatorBuilder: (context, url,
                                                downloadProgress) =>
                                                CircularProgressIndicator(
                                                    value: downloadProgress
                                                        .progress),
                                            errorWidget: (context, url,
                                                error) => const Icon(
                                              CupertinoIcons.person_alt_circle,
                                              size: 42,),
                                          ),
                                        ),
                                      ),
                                      const Divider(
                                        height: 14,
                                        thickness: 2,
                                        color: Colors.grey,
                                        indent: 4,
                                        endIndent: 4,
                                      ),
                                    ],
                                  );
                                }
                            ),
                          );
                        }else{
                          return const Column(crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 66,),
                              Center(child: SizedBox(height: 28,width: 28,child: CircularProgressIndicator(strokeWidth: 1.8,color: Colors.blue,),)),
                            ],
                          );
                        }
                      }
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    context.read<SearchCubit>().reset();
    super.dispose();
  }
}
