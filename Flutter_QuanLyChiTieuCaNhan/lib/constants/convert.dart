
String Themdaucham(int sovao) {
  String kq='';
  int sodu;
  if(sovao == null ||sovao<=0){
    return "0";
  }
  else {
    int dem=0;
    while (sovao > 0) {
      dem++;
      sodu=sovao % 10;
      kq =(sodu).toString() + kq;
      sovao=sovao~/10 ;
      if (dem%3==0 && sovao!=0){
        kq ='.' + kq;
      }

    };

  }
  return kq;
}
