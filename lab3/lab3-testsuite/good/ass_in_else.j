;; BEGIN HEADER

.class public ass_in_else
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

  invokestatic ass_in_else/main()I
  pop
  return

.end method

;; END HEADER

.method public static nop()V
  .limit locals 0
  .limit stack  100
return

.end method

.method public static main()I
  .limit locals 1
  .limit stack  100
  ;; int x = 5;
  ldc 5
  istore 0
  ;; if (false) (void) nop ();
  ;; else (int) x = 7;
  ldc 0
  ifeq L1
  ;; (void) nop ();
  invokestatic ass_in_else/nop()V

  goto L0
  L1:
  ;; (int) x = 7;
  ldc 7
  nop
  dup
  istore 0
  pop 
  L0:
  ;; (void) printInt (x);
  iload 0
  invokestatic Runtime/printInt(I)V

  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
