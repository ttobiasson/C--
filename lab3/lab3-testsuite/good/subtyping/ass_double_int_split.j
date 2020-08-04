;; BEGIN HEADER

.class public ass_double_int_split
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

  invokestatic ass_double_int_split/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 2
  .limit stack  100
  ;; double x;
  ;; (double) x = 1;
  ldc 1
  i2d
  dup2
  dstore 0
  pop2 
  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
