int[] list = new int[7];

for (int i = 0; i < list.length; i++) {
    list[i] = (int)random(1000);
}

System.out.print("정렬 전: ");
for (int i = 0; i < list.length; i++) {
    System.out.print(list[i] + " ");
}
System.out.println();

for (int i = 1; i < list.length; i++) {
    int key = list[i];
    int j = i - 1;

    while (j >= 0 && list[j] > key) {
        list[j + 1] = list[j];
        j = j - 1;
    }
    list[j + 1] = key;
}

System.out.print("정렬 후: ");
for (int i = 0; i < list.length; i++) {
    System.out.print(list[i] + " ");
}
