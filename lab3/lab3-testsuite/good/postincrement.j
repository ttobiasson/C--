;; BEGIN HEADER

.class public postincrement
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

  invokestatic postincrement/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 2
  .limit stack  100
  ;; int j = 22;
  ldc 22
  istore 0
  ;; int k = 23;
  ldc 23
  istore 1
  ;; (int) j ++;
  iload 0
  dup
  ldc 1
  iadd
  istore 0
  pop 
  ;; (void) printInt (j);
  iload 0
  invokestatic Runtime/printInt(I)V

  ;; (void) printInt (k ++);
  iload 1
  dup
  ldc 1
  iadd
  istore 1
  invokestatic Runtime/printInt(I)V

  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method