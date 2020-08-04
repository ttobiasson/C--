;; BEGIN HEADER

.class public arith_ass_int_mult_double
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

  invokestatic arith_ass_int_mult_double/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 2
  .limit stack  100
  ;; double x;
  ;; (double) x = 2 double.* 3.14;
  ldc2_w 3.14
  ldc 2
  i2d
  dmul
  nop
  dup2
  dstore 0
  pop2 
  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
