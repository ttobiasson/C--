;; BEGIN HEADER

.class public core113
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

  invokestatic core113/main()I
  pop
  return

.end method

;; END HEADER

.method public static f(I)I
  .limit locals 3
  .limit stack  100
  ;; int y;
  ;; if (x int.< 100) {
  ;;   int x = 91;
  ;;   (int) y = x;
  ;;   }
  ;; else {
  ;;   (int) y = x;
  ;;   }
  ldc 1
  iload 0
  ldc 100
  if_icmplt L2
  pop 
  ldc 0
  L2:
  ifeq L1
  ;; {
  ;;   int x = 91;
  ;;   (int) y = x;
  ;;   }
  ;; int x = 91;
  ldc 91
  istore 2
  ;; (int) y = x;
  iload 2
  nop
  dup
  istore 1
  pop 
  goto L0
  L1:
  ;; {
  ;;   (int) y = x;
  ;;   }
  ;; (int) y = x;
  iload 0
  nop
  dup
  istore 1
  pop 
  L0:
  ;; return (int) y;
  iload 1
  ireturn 
ireturn

.end method

.method public static main()I
  .limit locals 0
  .limit stack  100
  ;; (void) printInt (f (45));
  ldc 45
  invokestatic core113/f(I)I
  invokestatic Runtime/printInt(I)V

  ;; (void) printInt (f (450));
  ldc 450
  invokestatic core113/f(I)I
  invokestatic Runtime/printInt(I)V

  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
