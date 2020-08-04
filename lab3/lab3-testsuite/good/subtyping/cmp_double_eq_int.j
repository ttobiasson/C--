;; BEGIN HEADER

.class public cmp_double_eq_int
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

  invokestatic cmp_double_eq_int/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 0
  .limit stack  100
  ;; (bool) 1.1 double.== 1;
  ldc2_w 1.1
  ldc 1
  i2d
  dcmpg
  ifeq L0
  ldc 0
  goto L1
  L0:
  ldc 1
  L1:
  pop 
  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
