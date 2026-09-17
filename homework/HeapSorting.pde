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

  heapSort(list);

  print("정렬 후: ");
  for(int i=0; i<list.length; i++){
    print(list[i] + " ");
  }
  println();
}

void heapSort(int[] list) {
  int n = list.length;

  for (int i = n / 2 - 1; i >= 0; i--) {
    heapify(list, n, i);
  }

  for (int i = n - 1; i > 0; i--) {
    int temp = list[0];
    list[0] = list[i];
    list[i] = temp;

    heapify(list, i, 0);
  }
}

void heapify(int[] list, int n, int i) {
  int largest = i;
  int left = 2 * i + 1;
  int right = 2 * i + 2;

  if (left < n && list[left] > list[largest]) {
    largest = left;
  }

  if (right < n && list[right] > list[largest]) {
    largest = right;
  }

  if (largest != i) {
    int temp = list[i];
    list[i] = list[largest];
    list[largest] = temp;

    heapify(list, n, largest);
  }
}
