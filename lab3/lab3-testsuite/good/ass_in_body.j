;; BEGIN HEADER

.class public ass_in_body
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

  invokestatic ass_in_body/main()I
  pop
  return

.end method

;; END HEADER

.method public static f(I)I
  .limit locals 1
  .limit stack  100
  ;; (int) x = 7;
  ldc 7
  nop
  dup
  istore 0
  pop 
  ;; return (int) x;
  iload 0
  ireturn 
ireturn

.end method

.method public static main()I
  .limit locals 0
  .limit stack  100
  ;; (void) printInt (f (5));
  ldc 5
  invokestatic ass_in_body/f(I)I
  invokestatic Runtime/printInt(I)V

  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
