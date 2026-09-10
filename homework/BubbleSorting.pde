int[] list = new int[7];

for(int i=0; i<list.length; i++){
  list[i] = (int)random(1000);
}

for(int i=0; i<list.length; i++){
  print(list[i], "\t");
}
println(" ");

for (int i = 0; i < list.length - 1; i++) {
    for (int j = 0; j < list.length - 1 - i; j++) {
        if (list[j] > list[j + 1]) {
            int temp = list[j];
            list[j] = list[j + 1];
            list[j + 1] = temp;
        }
    }
}

for (int i = 0; i < list.length; i++) {
  print(list[i] + "\t");
}
println(" ");

for (int i = 0; i < list.length / 2; i++) {
    int temp = list[i];
    list[i] = list[list.length - 1 - i];
    list[list.length - 1 - i] = temp;
}

for (int i = 0; i < list.length; i++) {
  print(list[i] + "\t");
}
println(" ");
