;; BEGIN HEADER

.class public void_return
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

  invokestatic void_return/main()I
  pop
  return

.end method

;; END HEADER

.method public static ret()V
  .limit locals 0
  .limit stack  100
  ;; return (void) printInt (0);
  ldc 0
  invokestatic Runtime/printInt(I)V
  return
return

.end method

.method public static main()I
  .limit locals 0
  .limit stack  100
  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
