;; BEGIN HEADER

.class public core105
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

  invokestatic core105/main()I
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
  ;; while (x int.> 3)
  L0:
  ldc 1
  iload 0
  ldc 3
  if_icmpgt L2
  pop 
  ldc 0
  L2:
  ifeq L1
  ;; (void) printInt (x --);
  iload 0
  dup
  ldc 1
  isub
  istore 0
  invokestatic Runtime/printInt(I)V

  goto L0
  L1:
  ;; return (int) x;
  iload 0
  ireturn 
ireturn

.end method
