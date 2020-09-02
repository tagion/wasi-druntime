
class A {
    int x;
    this(int x) {
        this.x=x;
    }
}

void main() {
    int[] array;
    import core.stdc.stdio;
    printf("Yes it works!\n");
    int i;
    array~=10;
    printf("array[%d]=%d\n", i, array[i]);

    auto a=new A(42);
    printf("a.x=%d\n", a.x);

}
