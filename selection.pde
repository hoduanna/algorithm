int[] list = new int[100];

for(int i=0; i<list.length; i++){
  list[i] = (int)random(1000);
}

println(list.length);

for(int i=0; i<list.length; i++){
  println(list[i]);
}

line(0,0,100,100);

for (int i = 0; i < list.length - 1; i++) {
    for (int j = 0; j < list.length - 1 - i; j++) {
        if (list[j] > list[j + 1]) {
            int temp = list[j];
            list[j] = list[j + 1];
            list[j + 1] = temp;
        }
    }
}

println(list);
println();

for (int i = 0; i < list.length / 2; i++) {
    int temp = list[i];
    list[i] = list[list.length - 1 - i];
    list[list.length - 1 - i] = temp;
}

println(list);
