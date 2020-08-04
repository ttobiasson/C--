;; BEGIN HEADER

.class public redeclare_in_if
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

  invokestatic redeclare_in_if/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 3
  .limit stack  100
  ;; int x0 = 32;
  ldc 32
  istore 0
  ;; if (0 int.< 1 int.- 0) bool x0 = true;
  ;; else bool x0 = false;
  ldc 1
  ldc 0
  ldc 1
  ldc 0
  isub
  if_icmplt L2
  pop 
  ldc 0
  L2:
  ifeq L1
  ;; bool x0 = true;
  ldc 1
  istore 1
  goto L0
  L1:
  ;; bool x0 = false;
  ldc 0
  istore 2
  L0:
  ;; (void) printInt (x0);
  iload 0
  invokestatic Runtime/printInt(I)V

  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
