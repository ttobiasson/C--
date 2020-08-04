;; BEGIN HEADER

.class public arith_double_plus_int
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

  invokestatic arith_double_plus_int/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 0
  .limit stack  100
  ;; (double) 1.1 double.+ 1;
  ldc2_w 1.1
  ldc 1
  i2d
  dadd
  pop2 
  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
