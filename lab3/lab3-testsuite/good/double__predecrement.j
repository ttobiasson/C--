;; BEGIN HEADER

.class public double__predecrement
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

  invokestatic double__predecrement/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 4
  .limit stack  100
  ;; double j = 22.5;
  ldc2_w 22.5
  dstore 0
  ;; double k = 23.5;
  ldc2_w 23.5
  dstore 2
  ;; (double) -- j;
  dload 0
  ldc2_w 1.0
  dsub
  dup2
  dstore 0
  pop2 
  ;; (void) printDouble (j);
  dload 0
  invokestatic Runtime/printDouble(D)V

  ;; (void) printDouble (-- k);
  dload 2
  ldc2_w 1.0
  dsub
  dup2
  dstore 2
  invokestatic Runtime/printDouble(D)V

  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
