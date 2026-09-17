int[] list = new int[7];

void setup() {
  for (int i = 0; i < list.length; i++) {
    list[i] = (int) random(1000);
  }

  print("정렬 전: ");
  for(int i=0; i<list.length; i++){
    print(list[i] + " ");
  }
  println();

  quickSort(list, 0, list.length - 1);

  print("정렬 후: ");
  for(int i=0; i<list.length; i++){
    print(list[i] + " ");
  }
  println();
}

void quickSort(int[] list, int low, int high) {
  if (low < high) {
    int pi = partition(list, low, high);

    quickSort(list, low, pi - 1);
    quickSort(list, pi + 1, high);
  }
}

int partition(int[] list, int low, int high) {
  int pivot = list[high];
  int i = low - 1;

  for (int j = low; j < high; j++) {
    if (list[j] < pivot) {
      i++;
      int temp = list[i];
      list[i] = list[j];
      list[j] = temp;
    }
  }

  int temp = list[i + 1];
  list[i + 1] = list[high];
  list[high] = temp;

  return i + 1;
}
