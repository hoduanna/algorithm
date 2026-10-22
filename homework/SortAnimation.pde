ArrayList<Array> lists;
ArrayList<Integer> los, his;
Array list;
int[] a;
int[] base;
int type=0, napTime=10, len=16, index=0, loop=0;
int holdTime=1000;
int holdStart=-1;
boolean autoFlag=true;
String[] titles = {"selectionSort", "bubbleSort", "insertSort", "mergeSort", "quickSort", "heapSort"};
PFont f;

void setup() {
  size(900, 600);
  f = createFont("Arial-BoldMT-48.vlw", 24);
  textFont(f);
  newBase();
  run(type);
}

void draw() {
  background(200);
  list = lists.get(index);
  list.draw();

  text(titles[type], 20, 40);

  if (index==loop) {
    fill(0, 140, 0);
    String msg = "";
    if (holdStart>=0 && autoFlag) {
      int remain = ceil((holdTime-(millis()-holdStart))/1000.0);
      if (remain < 0) remain = 0;
      String nextName = (type+1<titles.length) ? titles[type+1] : titles[0]+" (new data)";
      msg += "  next: "+nextName+" in "+remain+"s";
    }
    text(msg, 20, 75);
  }
  if(autoFlag) nextStep();
}

void nextStep() {
  if (index<loop) {
    holdStart = -1;
    if(index==0)
      delay(10*napTime);
    else
      delay(napTime);
    index++;
  }
  else {
    if (holdStart<0) holdStart = millis();
    else if (millis()-holdStart >= holdTime) {
      type++;
      if (type>=titles.length) {
        type = 0;
        newBase();
      }
      run(type);
    }
  }
}

void keyPressed() {
  if(key == ' ') {
    autoFlag = !autoFlag;
    holdStart = -1;
  }
  else if(key == 'a') {
    if(napTime>100)
      napTime -= 100;
  }
  else if(key == 's') {
    napTime += 100;
  }
  else if(key == 'z') {
    if(type>0){
      type--;
      run(type);
    }
  }
  else if(key == 'x') {
    if(type<titles.length-1) {
      type++;
      run(type);
    }
  }
  else if(key == 'r') {
    newBase();
    run(type);
  }
  else if (key == CODED) {
    if (keyCode == LEFT) {
      if(index>0) index--;
    } else if (keyCode == RIGHT) {
      if(index<loop) index++;
    }
  }
}

void mousePressed() {
  if(autoFlag) autoFlag=false;
  holdStart = -1;
  if(mouseButton == LEFT) {
    if(index>0) index--;
  }
  else if(mouseButton == RIGHT) {
    if(index<loop) index++;
  }
}

void newBase() {
  base = new int[len];
  for (int i=0; i<len; i++)
    base[i] = (int)random(100);
}

void snap(int i0, int j0, int lo, int hi) {
  lists.add(new Array(len, a, i0, j0));
  los.add(lo);
  his.add(hi);
  loop++;
}

void run(int type) {
  loop = -1;
  index = 0;
  holdStart = -1;
  a = new int[len];
  for (int i=0; i<len; i++) a[i] = base[i];
  lists = new ArrayList<Array>();
  los = new ArrayList<Integer>();
  his = new ArrayList<Integer>();
  snap(0, -1, -1, -1);
  loop = 0;
  if (type==0) selectionSort();
  else if (type==1) bubbleSort();
  else if (type==2) insertSort();
  else if (type==3) mergeSort();
  else if (type==4) quickSort();
  else if (type==5) heapSort();
  snap(0, -1, -1, -1);
  lists.get(0).printArray();
  lists.get(loop).printArray();
}

void selectionSort() {
  int i, j, m;
  for (i=len-1; i>0; i--) {
    m = 0;
    for (j=1; j<=i; j++) {
      snap(len-1-i, j, 0, i);
      if (a[j] > a[m]) m = j;
    }
    swap(a, m, i);
    snap(len-1-i, i, 0, i);
  }
}

void bubbleSort() {
  int i, j;
  for (j=0; j<len-1; j++) {
    for (i=0; i<len-j-1; i++) {
      snap(j+1, i, 0, len-j-1);
      if (a[i] > a[i+1]) {
        swap(a, i, i+1);
        snap(j+1, i+1, 0, len-j-1);
      }
    }
  }
}

void insertSort() {
  int i, j, temp;
  for (i=1; i<len; i++) {
    temp = a[i];
    snap(i, i, 0, i);
    for (j=i-1; j>=0 && temp<a[j]; j--) {
      a[j+1] = a[j];
      snap(i, j, 0, i);
    }
    a[j+1] = temp;
    snap(i, j+1, 0, i);
  }
}

void mergeSort() {
  mergeSort(0, len-1);
}

void mergeSort(int low, int high) {
  if (low < high) {
    int middle = low + (high - low)/2;
    snap(low, -1, low, high);
    mergeSort(low, middle);
    mergeSort(middle + 1, high);
    merge(low, middle, high);
  }
}

void merge(int low, int middle, int high) {
  int i, j, k;
  int[] t = new int[len];
  for (i = low; i <= high; i++) t[i] = a[i];
  i = low;
  j = middle + 1;
  k = low;
  while (i <= middle && j <= high) {
    if (t[i] <= t[j]) a[k] = t[i++];
    else a[k] = t[j++];
    snap(low, k, low, high);
    k++;
  }
  while (i <= middle) {
    a[k] = t[i++];
    snap(low, k, low, high);
    k++;
  }
  while (j <= high) {
    a[k] = t[j++];
    snap(low, k, low, high);
    k++;
  }
}

void quickSort() {
  quickSort(0, len-1);
}

void quickSort(int low, int high) {
  if (low >= high) return;
  int pivot = a[high];
  int i = low, j;
  for (j = low; j < high; j++) {
    snap(i, j, low, high);
    if (a[j] < pivot) {
      swap(a, i, j);
      i++;
      snap(i, j, low, high);
    }
  }
  swap(a, i, high);
  snap(i, i, low, high);
  quickSort(low, i-1);
  quickSort(i+1, high);
}

void heapSort() {
  int end;
  for (int s = len/2 - 1; s >= 0; s--)
    siftDown(s, len);
  for (end = len-1; end > 0; end--) {
    swap(a, 0, end);
    snap(0, end, 0, end-1);
    siftDown(0, end);
  }
}

void siftDown(int root, int n) {
  int child;
  while (2*root+1 < n) {
    child = 2*root+1;
    if (child+1 < n && a[child] < a[child+1]) child++;
    snap(root, child, 0, n-1);
    if (a[root] < a[child]) {
      swap(a, root, child);
      snap(root, child, 0, n-1);
      root = child;
    } else break;
  }
}

void swap(int[] arr, int i, int j) {
  int tmp=arr[j];
  arr[j] = arr[i];
  arr[i] = tmp;
}
