class Pair<T, E> {
  T first;
  E last;

  Pair(T first, E last){
    this.first = first;
    this.last = last;
  }

  T getFirst(){
    return first;
  }

  E getLast(){
    return last;
  }
}