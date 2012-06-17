
/// ViewModelBase allows the class to implement [FrameworkProperty]s
class ViewModel extends ViewModelBase 
{
  FrameworkProperty amountProperty;
  FrameworkProperty areaProperty;
  FrameworkProperty buytaxProperty;
  
  
  FrameworkProperty statusTextProperty;
  FrameworkProperty statusColorProperty;
  FrameworkProperty itemsProperty;
  
  final Brush bad;
  final Brush good;
  
  ViewModel()
  :
    bad = new SolidColorBrush(new Color.predefined(Colors.Red)),
    good = new SolidColorBrush(new Color.predefined(Colors.Green))
  {
    
    amountProperty = new FrameworkProperty(this, "amount", (_){}, "0");
    
    areaProperty = new FrameworkProperty(this, "area", (_){}, "0");
    
    buytaxProperty = new FrameworkProperty(this, "buytax", (_){}, "0");

    statusTextProperty = new FrameworkProperty(this, "statusText", (_){}, "");
    
    statusColorProperty = new FrameworkProperty(this, "statusColor", (_){}, good);
    
    itemsProperty = new FrameworkProperty(this, "items", (_){}, new ObservableList());
  }
  
  void addNewEntry(){
    if (amount.isEmpty() || area.isEmpty()){
      statusColor = bad;
      statusText = "입력값이 부족합니다.";
    }else{
      statusColor = good;
      statusText = "계산되었습니다.";
      
      //using a DataTemplate so the view can bind to the list by referening the
      //property names in the map.
      // This saves the task of having to create a dedicated class
      items.clear();
      
      var _amount = Math.parseInt( amount) * 10000;
      var _area =  Math.parseInt(area);
      var _buytax = _amount * 0.022 ;
      
      
      items.add(new DataTemplate.fromMap({"amount" : amount, "area" : area,"buytax":_buytax}));
      
      amount = "0";
      area = "0";
    }
  }
  
  //convenience getters/setters for our properties.
  
  ObservableList get items() => getValue(itemsProperty);
  
  String get amount() => getValue(amountProperty);
  set amount(num value) => setValue(amountProperty, value);
  
  String get area() => getValue(areaProperty);
  set area(num value) => setValue(areaProperty, value);
  
  String get statusText() => getValue(statusTextProperty);
  set statusText(String value) => setValue(statusTextProperty, value);
  
  Brush get statusColor() => getValue(statusColorProperty);
  set statusColor(Brush value) => setValue(statusColorProperty, value);
  
}
