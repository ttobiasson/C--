;; BEGIN HEADER

.class public ass_in_cmp
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

  invokestatic ass_in_cmp/main()I
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
  ;; if (++ x int.== x ++) (void) printInt (x);
  ;; else (void) printInt (0);
  ldc 1
  iload 0
  ldc 1
  iadd
  dup
  istore 0
  iload 0
  dup
  ldc 1
  iadd
  istore 0
  if_icmpeq L2
  pop 
  ldc 0
  L2:
  ifeq L1
  ;; (void) printInt (x);
  iload 0
  invokestatic Runtime/printInt(I)V

  goto L0
  L1:
  ;; (void) printInt (0);
  ldc 0
  invokestatic Runtime/printInt(I)V

  L0:
  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
