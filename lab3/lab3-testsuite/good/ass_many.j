;; BEGIN HEADER

.class public ass_many
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

  invokestatic ass_many/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 3
  .limit stack  100
  ;; int x, j, i;
  ;; (int) j = i = 6;
  ldc 6
  nop
  dup
  istore 2
  nop
  dup
  istore 1
  pop 
  ;; (void) printInt (i int.+ j);
  iload 2
  iload 1
  iadd
  invokestatic Runtime/printInt(I)V

  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
