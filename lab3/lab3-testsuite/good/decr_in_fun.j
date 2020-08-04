;; BEGIN HEADER

.class public decr_in_fun
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

  invokestatic decr_in_fun/main()I
  pop
  return

.end method

;; END HEADER

.method public static f(I)I
  .limit locals 1
  .limit stack  100
  ;; return (int) -- y;
  iload 0
  ldc 1
  isub
  dup
  istore 0
  ireturn 
ireturn

.end method

.method public static main()I
  .limit locals 0
  .limit stack  100
  ;; (void) printInt (f (0));
  ldc 0
  invokestatic decr_in_fun/f(I)I
  invokestatic Runtime/printInt(I)V

  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
