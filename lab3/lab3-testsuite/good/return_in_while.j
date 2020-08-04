;; BEGIN HEADER

.class public return_in_while
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

  invokestatic return_in_while/main()I
  pop
  return

.end method

;; END HEADER

.method public static rRrrrRrrrReturn()I
  .limit locals 1
  .limit stack  100
  ;; int i = 0;
  ldc 0
  istore 0
  ;; while (i ++ int.< 5)
  L0:
  ldc 1
  iload 0
  dup
  ldc 1
  iadd
  istore 0
  ldc 5
  if_icmplt L2
  pop 
  ldc 0
  L2:
  ifeq L1
  ;; {
  ;;   return (int) 71;
  ;;   }
  ;; return (int) 71;
  ldc 71
  ireturn 
  goto L0
  L1:
  ;; return (int) 52;
  ldc 52
  ireturn 
ireturn

.end method

.method public static main()I
  .limit locals 0
  .limit stack  100
  ;; (void) printInt (rRrrrRrrrReturn ());
  invokestatic return_in_while/rRrrrRrrrReturn()I
  invokestatic Runtime/printInt(I)V

  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
