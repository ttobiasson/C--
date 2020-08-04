;; BEGIN HEADER

.class public var_mutation_init_pinc
.super java/lang/Object

.method public <init>()V
  .limit locals 1

  aload_0
  invokespecial java/lang/Object/<init>()V
  return

.end method

.method public static main([Ljava/lang/String;)V
  .limit locals 1
  .limit stack  1

  invokestatic var_mutation_init_pinc/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 2
  .limit stack  100
  ;; int a = 0 int.- 1;
  ldc 0
  ldc 1
  isub
  istore 0
  ;; int b = ++ a;
  iload 0
  ldc 1
  iadd
  dup
  istore 0
  istore 1
  ;; (int) ++ b;
  iload 1
  ldc 1
  iadd
  dup
  istore 1
  pop 
  ;; (void) printInt (a);
  iload 0
  invokestatic Runtime/printInt(I)V

  ;; (int) b ++;
  iload 1
  dup
  ldc 1
  iadd
  istore 1
  pop 
  ;; (void) printInt (a);
  iload 0
  invokestatic Runtime/printInt(I)V

  ;; (int) -- b;
  iload 1
  ldc 1
  isub
  dup
  istore 1
  pop 
  ;; (void) printInt (a);
  iload 0
  invokestatic Runtime/printInt(I)V

  ;; (int) b --;
  iload 1
  dup
  ldc 1
  isub
  istore 1
  pop 
  ;; (void) printInt (a);
  iload 0
  invokestatic Runtime/printInt(I)V

  ;; (int) b = 832;
  ldc 832
  nop
  dup
  istore 1
  pop 
  ;; (void) printInt (a);
  iload 0
  invokestatic Runtime/printInt(I)V

  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
