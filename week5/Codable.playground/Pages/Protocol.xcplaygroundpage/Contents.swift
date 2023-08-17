//protocol self exercise
protocol Test{  }

class A: Test{  }

class B: Test{  }

class C: A{ }
//Protocol as a type
let example1: Test = A()
let value: A = C()


