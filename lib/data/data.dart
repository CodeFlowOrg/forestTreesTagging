import 'package:flutter/material.dart';


class SliderModel{

  String imageAssetPath;
  String title;
  String desc;

  SliderModel({this.imageAssetPath,this.title,this.desc});

  void setImageAssetPath(String getImageAssetPath){
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle){
    title = getTitle;
  }

  void setDesc(String getDesc){
    desc = getDesc;
  }

  String getImageAssetPath(){
    return imageAssetPath;
  }

  String getTitle(){
    return title;
  }

  String getDesc(){
    return desc;
  }

}


List<SliderModel> getSlides(){

  // ignore: deprecated_member_use
  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setDesc("Digital transformation of maintaining the records of forest trees.");
  sliderModel.setTitle("Tag Trees!");
  sliderModel.setImageAssetPath("assets/images/onboard_1.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setDesc("QR code generation for unique identification of every tree, prediction of different parameters and much more!");
  sliderModel.setTitle("Locate Trees!");
  sliderModel.setImageAssetPath("assets/images/onboard_2.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setDesc("Our app helps in analyzing the various aspects regarding trees; diversity, age, height, growth, and much more");
  sliderModel.setTitle("Save Trees!");
  sliderModel.setImageAssetPath("assets/images/onboard_3.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  return slides;
}