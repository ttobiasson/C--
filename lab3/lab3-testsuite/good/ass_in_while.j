;; BEGIN HEADER

.class public ass_in_while
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

  invokestatic ass_in_while/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 1
  .limit stack  100
  ;; int x = 5;
  ldc 5
  istore 0
  ;; while (x int.== 5)
  L0:
  ldc 1
  iload 0
  ldc 5
  if_icmpeq L2
  pop 
  ldc 0
  L2:
  ifeq L1
  ;; (int) x = 7;
  ldc 7
  nop
  dup
  istore 0
  pop 
  goto L0
  L1:
  ;; (void) printInt (x);
  iload 0
  invokestatic Runtime/printInt(I)V

  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
