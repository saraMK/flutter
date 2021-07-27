import 'package:conditional_builder/conditional_builder.dart';import 'package:flutter/cupertino.dart';import 'package:flutter/material.dart';import 'package:flutter_app2/layout/categories/category_item.dart';import 'package:flutter_app2/models/categories_model/Category.dart';import 'package:flutter_app2/module/products/products_screen.dart';import 'package:flutter_bloc/flutter_bloc.dart';import 'cubit/categoryCubit.dart';import 'cubit/states.dart';class SubCategoriesLayout extends StatelessWidget {  Widget build(BuildContext context) {    //var bloc= CategoryCubit.get(context);     List<CategoryModel> list=[];     list = ModalRoute.of(context).settings.arguments as List<CategoryModel>;    return Scaffold(      appBar: AppBar(        backgroundColor: Colors.white,      ),        body: BlocProvider<CategoryCubit>(        create: (context) => CategoryCubit()..setList(list),        child: BlocConsumer<CategoryCubit, CategoryStates>(          builder: (context, state) {            var bloc = CategoryCubit.get(context);            return   ConditionalBuilder(              condition: state is CategoriesLoading,              builder: (context) => Center(                  child: CircularProgressIndicator(                backgroundColor: Colors.red,              )),              fallback: (context) => Container(                width: double.infinity,                padding: EdgeInsets.all(15),                child: Column(                  children: [                    Container(                        height: 40,                        padding: EdgeInsets.symmetric(horizontal: 5),                        decoration: BoxDecoration(                          borderRadius: BorderRadius.circular(5),                          color: Colors.grey[200],                        ),                        child: TextFormField(                            maxLines: 1,                            onChanged: (txt) {                              bloc.search(txt);                            },                            decoration: InputDecoration(                              border: InputBorder.none,                              hintText: 'Search',                              prefixIcon: Icon(Icons.search),                            ))),                    SizedBox(                      height: 10,                    ),                    Flexible(                      flex: 1,                      child: ListView.separated(                        physics: BouncingScrollPhysics(),                        shrinkWrap: true,                        itemBuilder: (context, index) => GestureDetector(                            onTap: () =>Navigator.push(                                context,                                MaterialPageRoute(builder: (context) => ProductsScreen(),                                  settings: RouteSettings(                                    arguments: bloc.catgoryList[index].id                                    ,),                                )),                            child: CategoryItem(bloc.catgoryList[index])),                        separatorBuilder: (context, index) => SizedBox(                          height: 5,                        ),                        itemCount: bloc.catgoryList.length,                        scrollDirection: Axis.vertical,                      ),                    ),                  ],                ),              ),            ) ;          },          listener: (context, state) {},        )));  }}