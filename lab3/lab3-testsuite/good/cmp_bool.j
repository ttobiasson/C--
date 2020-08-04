;; BEGIN HEADER

.class public cmp_bool
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

  invokestatic cmp_bool/main()I
  pop
  return

.end method

;; END HEADER

.method public static printBool(Z)V
  .limit locals 1
  .limit stack  100
  ;; if (b) (void) printInt (1);
  ;; else (void) printInt (0);
  iload 0
  ifeq L1
  ;; (void) printInt (1);
  ldc 1
  invokestatic Runtime/printInt(I)V

  goto L0
  L1:
  ;; (void) printInt (0);
  ldc 0
  invokestatic Runtime/printInt(I)V

  L0:
return

.end method

.method public static main()I
  .limit locals 0
  .limit stack  100
  ;; (void) printBool (true bool.== true);
  ldc 1
  ldc 1
  ldc 1
  if_icmpeq L2
  pop 
  ldc 0
  L2:
  invokestatic cmp_bool/printBool(Z)V

  ;; (void) printBool (true bool.== false);
  ldc 1
  ldc 1
  ldc 0
  if_icmpeq L3
  pop 
  ldc 0
  L3:
  invokestatic cmp_bool/printBool(Z)V

  ;; (void) printBool (true bool.!= false);
  ldc 1
  ldc 1
  ldc 0
  if_icmpne L4
  pop 
  ldc 0
  L4:
  invokestatic cmp_bool/printBool(Z)V

  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
