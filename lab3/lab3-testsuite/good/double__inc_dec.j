;; BEGIN HEADER

.class public double__inc_dec
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

  invokestatic double__inc_dec/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 2
  .limit stack  100
  ;; double d = 2.0;
  ldc2_w 2.0
  dstore 0
  ;; (void) printDouble (d);
  dload 0
  invokestatic Runtime/printDouble(D)V

  ;; (double) d ++;
  dload 0
  dup2
  ldc2_w 1.0
  dadd
  dstore 0
  pop2 
  ;; (void) printDouble (d);
  dload 0
  invokestatic Runtime/printDouble(D)V

  ;; (double) d --;
  dload 0
  dup2
  ldc2_w 1.0
  dsub
  dstore 0
  pop2 
  ;; (void) printDouble (d);
  dload 0
  invokestatic Runtime/printDouble(D)V

  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
