;; BEGIN HEADER

.class public redeclare_in_while
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

  invokestatic redeclare_in_while/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 2
  .limit stack  100
  ;; int n = 0;
  ldc 0
  istore 0
  ;; while (n ++ int.< 10)
  L0:
  ldc 1
  iload 0
  dup
  ldc 1
  iadd
  istore 0
  ldc 10
  if_icmplt L2
  pop 
  ldc 0
  L2:
  ifeq L1
  ;; int n = 100;
  ldc 100
  istore 1
  goto L0
  L1:
  ;; (void) printInt (n);
  iload 0
  invokestatic Runtime/printInt(I)V

  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
