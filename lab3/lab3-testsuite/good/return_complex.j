;; BEGIN HEADER

.class public return_complex
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

  invokestatic return_complex/main()I
  pop
  return

.end method

;; END HEADER

.method public static foo(I)Z
  .limit locals 2
  .limit stack  100
  ;; if (x int.== 0) {
  ;;   return (bool) false;
  ;;   }
  ;; else {
  ;;   }
  ldc 1
  iload 0
  ldc 0
  if_icmpeq L2
  pop 
  ldc 0
  L2:
  ifeq L1
  ;; {
  ;;   return (bool) false;
  ;;   }
  ;; return (bool) false;
  ldc 0
  ireturn 
  goto L0
  L1:
  ;; {
  ;;   }
  L0:
  ;; bool b = true;
  ldc 1
  istore 1
  ;; (void) printInt (x);
  iload 0
  invokestatic Runtime/printInt(I)V

  ;; return (bool) b;
  iload 1
  ireturn 
ireturn

.end method

.method public static printBool(Z)V
  .limit locals 1
  .limit stack  100
  ;; if (false) {
  ;;   }
  ;; else if (b) {
  ;;   (void) printInt (0);
  ;;   }
  ;; else {
  ;;   (void) printInt (1);
  ;;   }
  ldc 0
  ifeq L4
  ;; {
  ;;   }
  goto L3
  L4:
  ;; if (b) {
  ;;   (void) printInt (0);
  ;;   }
  ;; else {
  ;;   (void) printInt (1);
  ;;   }
  iload 0
  ifeq L6
  ;; {
  ;;   (void) printInt (0);
  ;;   }
  ;; (void) printInt (0);
  ldc 0
  invokestatic Runtime/printInt(I)V

  goto L5
  L6:
  ;; {
  ;;   (void) printInt (1);
  ;;   }
  ;; (void) printInt (1);
  ldc 1
  invokestatic Runtime/printInt(I)V

  L5:
  L3:
return

.end method

.method public static main()I
  .limit locals 0
  .limit stack  100
  ;; (void) printBool (foo (42));
  ldc 42
  invokestatic return_complex/foo(I)Z
  invokestatic return_complex/printBool(Z)V

  ;; (void) printBool (foo (0));
  ldc 0
  invokestatic return_complex/foo(I)Z
  invokestatic return_complex/printBool(Z)V

  ;; return (int) 0;
  ldc 0
  ireturn 
  ;; (void) printBool (true);
  ldc 1
  invokestatic return_complex/printBool(Z)V

ireturn

.end method
