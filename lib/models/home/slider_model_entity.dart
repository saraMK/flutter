class SliderModelHomePageSlider {	List<SliderItem> sliderList=[];	SliderModelHomePageSlider(this.sliderList);  factory SliderModelHomePageSlider.fromJson(Map json){		return	SliderModelHomePageSlider(List.from(json['HomePageSlider']).map((item)=>SliderItem.fromJson(item)).toList());	}}class SliderItem{	String ImageURL;	SliderItem(this.ImageURL);  factory SliderItem.fromJson(Map<String,dynamic> json){		return SliderItem(json['ImageURL']);	}}