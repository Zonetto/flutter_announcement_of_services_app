
validTextForm(var value,int max,int min,String type){
  
  if( value.isEmpty ||value==null){
    return "لا يمكن ترك الحقل فارغ";

}

 if(value.length > max){
    return " رقم الهاتف  يجب ان يكون اصغر من$max رقم ";

}
 if(value.length < min){
    return "رقم الهاتف  يجب ان يتكون من$min رقم";

}
}