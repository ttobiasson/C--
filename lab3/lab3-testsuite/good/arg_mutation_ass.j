;; BEGIN HEADER

.class public arg_mutation_ass
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

  invokestatic arg_mutation_ass/main()I
  pop
  return

.end method

;; END HEADER

.method public static cdec(I)V
  .limit locals 1
  .limit stack  100
  ;; (int) c --;
  iload 0
  dup
  ldc 1
  isub
  istore 0
  pop 
return

.end method

.method public static main()I
  .limit locals 1
  .limit stack  100
  ;; int c;
  ;; (void) cdec (c = 0);
  ldc 0
  nop
  dup
  istore 0
  invokestatic arg_mutation_ass/cdec(I)V

  ;; (void) printInt (c);
  iload 0
  invokestatic Runtime/printInt(I)V

  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method