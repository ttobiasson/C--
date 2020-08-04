;; BEGIN HEADER

.class public redeclare_in_block
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

  invokestatic redeclare_in_block/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 2
  .limit stack  100
  ;; int x0 = 32;
  ldc 32
  istore 0
  ;; {
  ;;   bool x0 = true;
  ;;   }
  ;; bool x0 = true;
  ldc 1
  istore 1
  ;; (void) printInt (x0);
  iload 0
  invokestatic Runtime/printInt(I)V

  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
