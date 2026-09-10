int[] list = new int[7];

void setup() {
  for (int i = 0; i < list.length; i++) {
    list[i] = (int)random(1000);
  }

  for (int i = 0; i < list.length; i++) {
    print(list[i], "\t");
  }
  println(" ");

  for (int i = 0; i < list.length - 1; i++) {
    int minIndex = i;
    for (int j = i + 1; j < list.length; j++) {
      if (list[j] < list[minIndex]) {
        minIndex = j;
      }
    }
    swap(i, minIndex);
  }

  for (int i = 0; i < list.length; i++) {
    print(list[i] + "\t");
  }
  println(" ");

  for (int i = 0; i < list.length / 2; i++) {
    swap(i, list.length - 1 - i);
  }

  for (int i = 0; i < list.length; i++) {
    print(list[i] + "\t");
  }
  println(" ");
}

void swap(int i, int j) {
  int temp = list[i];
  list[i] = list[j];
  list[j] = temp;
}
