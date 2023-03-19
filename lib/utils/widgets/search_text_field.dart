import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maak/utils/consts/app_colors.dart';
import 'package:maak/utils/consts/print_utils.dart';

class SearchTextForm extends StatefulWidget {

  final Function (String)onChangeHandler;
  const SearchTextForm({Key? key,required this.onChangeHandler}) : super(key: key);

  @override
  _SearchTextFormState createState() => _SearchTextFormState();
}

class _SearchTextFormState extends State<SearchTextForm> {


  Timer? searchOnStoppedTyping;

  _onChangeHandler(value ) {
    const duration = Duration(milliseconds:800); // set the duration that you want call search() after that.
    if (searchOnStoppedTyping != null) {
      setState(() => searchOnStoppedTyping!.cancel()); // clear timer
    }
    setState(() => searchOnStoppedTyping = new Timer(duration, () => search(value)));
  }

  search(value) {
    widget.onChangeHandler(value);
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 3000),
        height: AppBar().preferredSize.height - 16,
        width:  double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.unSelectedGray),
            borderRadius: BorderRadius.circular(50)
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 5),
                    hintText: 'البحث ...',
                  ),
                  onEditingComplete: (){
                    // _onChangeHandler(value);
                  },
                  onFieldSubmitted: (value){
                    FocusScope.of(context).unfocus();
                    _onChangeHandler(value);
                  },
                  onChanged: (value){
                    println('------------------------ guygyugyguyyugu ');
                    _onChangeHandler(value);
                  },
                ),
              ),
              Icon(Icons.search,color: Colors.grey,),
            ],
          ),
        ),
      ),
    );
  }
}
