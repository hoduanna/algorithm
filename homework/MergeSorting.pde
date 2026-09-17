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

  mergeSort(list, 0, list.length - 1);

  print("정렬 후: ");  
  for(int i=0; i<list.length; i++){
    print(list[i] + " ");
  }
}

void mergeSort(int[] list, int left, int right) {
  if (left < right) {
    int mid = (left + right) / 2;

    mergeSort(list, left, mid);
    mergeSort(list, mid + 1, right);
    merge(list, left, mid, right);
  }
}

void merge(int[] list, int left, int mid, int right) {
  int n1 = mid - left + 1;
  int n2 = right - mid;

  int[] L = new int[n1];
  int[] R = new int[n2];

  for (int i = 0; i < n1; i++) {
    L[i] = list[left + i];
  }
  for (int j = 0; j < n2; j++) {
    R[j] = list[mid + 1 + j];
  }

  int i = 0;
  int j = 0;
  int k = left;

  while (i < n1 && j < n2) {
    if (L[i] <= R[j]) {
      list[k] = L[i];
      i++;
    } else {
      list[k] = R[j];
      j++;
    }
    k++;
  }

  while (i < n1) {
    list[k] = L[i];
    i++;
    k++;
  }

  while (j < n2) {
    list[k] = R[j];
    j++;
    k++;
  }
}
