;; BEGIN HEADER

.class public core013
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

  invokestatic core013/main()I
  pop
  return

.end method

;; END HEADER

.method public static printBool(Z)V
  .limit locals 1
  .limit stack  100
  ;; if (b) {
  ;;   (void) printInt (1);
  ;;   }
  ;; else {
  ;;   (void) printInt (0);
  ;;   }
  iload 0
  ifeq L1
  ;; {
  ;;   (void) printInt (1);
  ;;   }
  ;; (void) printInt (1);
  ldc 1
  invokestatic Runtime/printInt(I)V

  goto L0
  L1:
  ;; {
  ;;   (void) printInt (0);
  ;;   }
  ;; (void) printInt (0);
  ldc 0
  invokestatic Runtime/printInt(I)V

  L0:
return

.end method

.method public static test(I)Z
  .limit locals 1
  .limit stack  100
  ;; return (bool) i int.> 0;
  ldc 1
  iload 0
  ldc 0
  if_icmpgt L2
  pop 
  ldc 0
  L2:
  ireturn 
ireturn

.end method

.method public static main()I
  .limit locals 0
  .limit stack  100
  ;; (void) printBool (test (0 int.- 1) && test (0));
  ldc 0
  ldc 1
  isub
  invokestatic core013/test(I)Z
  ifeq L3
  ldc 0
  invokestatic core013/test(I)Z
  ifeq L3
  ldc 1
  goto L4
  L3:
  ldc 0
  L4:
  invokestatic core013/printBool(Z)V

  ;; (void) printBool (test (0 int.- 2) || test (1));
  ldc 0
  ldc 2
  isub
  invokestatic core013/test(I)Z
  ifeq L5
  ldc 1
  goto L6
  L5:
  ldc 1
  invokestatic core013/test(I)Z
  ifeq L7
  ldc 1
  goto L6
  L7:
  ldc 0
  L6:
  invokestatic core013/printBool(Z)V

  ;; (void) printBool (test (3) && test (0 int.- 5) && true);
  ldc 3
  invokestatic core013/test(I)Z
  ifeq L8
  ldc 0
  ldc 5
  isub
  invokestatic core013/test(I)Z
  ifeq L8
  ldc 1
  goto L9
  L8:
  ldc 0
  L9:
  ifeq L10
  ldc 1
  ifeq L10
  ldc 1
  goto L11
  L10:
  ldc 0
  L11:
  invokestatic core013/printBool(Z)V

  ;; (void) printBool (test (3) || test (0 int.- 5) && true);
  ldc 3
  invokestatic core013/test(I)Z
  ifeq L12
  ldc 1
  goto L13
  L12:
  ldc 0
  ldc 5
  isub
  invokestatic core013/test(I)Z
  ifeq L15
  ldc 1
  ifeq L15
  ldc 1
  goto L16
  L15:
  ldc 0
  L16:
  ifeq L14
  ldc 1
  goto L13
  L14:
  ldc 0
  L13:
  invokestatic core013/printBool(Z)V

  ;; (void) printBool (true);
  ldc 1
  invokestatic core013/printBool(Z)V

  ;; (void) printBool (false);
  ldc 0
  invokestatic core013/printBool(Z)V

  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
