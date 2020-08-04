;; BEGIN HEADER

.class public eval_order
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

  invokestatic eval_order/main()I
  pop
  return

.end method

;; END HEADER

.method public static order(II)I
  .limit locals 2
  .limit stack  100
  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method

.method public static printIntInt(I)I
  .limit locals 1
  .limit stack  100
  ;; (void) printInt (i);
  iload 0
  invokestatic Runtime/printInt(I)V

  ;; return (int) i;
  iload 0
  ireturn 
ireturn

.end method

.method public static printIntBool(I)Z
  .limit locals 1
  .limit stack  100
  ;; (void) printInt (i);
  iload 0
  invokestatic Runtime/printInt(I)V

  ;; return (bool) true;
  ldc 1
  ireturn 
ireturn

.end method

.method public static main()I
  .limit locals 0
  .limit stack  100
  ;; (int) order (printIntInt (0), printIntInt (1));
  ldc 0
  invokestatic eval_order/printIntInt(I)I
  ldc 1
  invokestatic eval_order/printIntInt(I)I
  invokestatic eval_order/order(II)I
  pop 
  ;; (int) printIntInt (2) int.+ printIntInt (3);
  ldc 2
  invokestatic eval_order/printIntInt(I)I
  ldc 3
  invokestatic eval_order/printIntInt(I)I
  iadd
  pop 
  ;; (bool) printIntInt (4) int.== printIntInt (5);
  ldc 1
  ldc 4
  invokestatic eval_order/printIntInt(I)I
  ldc 5
  invokestatic eval_order/printIntInt(I)I
  if_icmpeq L0
  pop 
  ldc 0
  L0:
  pop 
  ;; (int) printIntInt (6) int.* printIntInt (7);
  ldc 6
  invokestatic eval_order/printIntInt(I)I
  ldc 7
  invokestatic eval_order/printIntInt(I)I
  imul
  pop 
  ;; (int) printIntInt (8) int./ printIntInt (9);
  ldc 8
  invokestatic eval_order/printIntInt(I)I
  ldc 9
  invokestatic eval_order/printIntInt(I)I
  idiv
  pop 
  ;; (int) printIntInt (10) int.- printIntInt (11);
  ldc 10
  invokestatic eval_order/printIntInt(I)I
  ldc 11
  invokestatic eval_order/printIntInt(I)I
  isub
  pop 
  ;; (bool) printIntInt (12) int.< printIntInt (13);
  ldc 1
  ldc 12
  invokestatic eval_order/printIntInt(I)I
  ldc 13
  invokestatic eval_order/printIntInt(I)I
  if_icmplt L1
  pop 
  ldc 0
  L1:
  pop 
  ;; (bool) printIntInt (14) int.> printIntInt (15);
  ldc 1
  ldc 14
  invokestatic eval_order/printIntInt(I)I
  ldc 15
  invokestatic eval_order/printIntInt(I)I
  if_icmpgt L2
  pop 
  ldc 0
  L2:
  pop 
  ;; (bool) printIntInt (16) int.<= printIntInt (17);
  ldc 1
  ldc 16
  invokestatic eval_order/printIntInt(I)I
  ldc 17
  invokestatic eval_order/printIntInt(I)I
  if_icmple L3
  pop 
  ldc 0
  L3:
  pop 
  ;; (bool) printIntInt (18) int.>= printIntInt (19);
  ldc 1
  ldc 18
  invokestatic eval_order/printIntInt(I)I
  ldc 19
  invokestatic eval_order/printIntInt(I)I
  if_icmpge L4
  pop 
  ldc 0
  L4:
  pop 
  ;; (bool) printIntInt (20) int.!= printIntInt (21);
  ldc 1
  ldc 20
  invokestatic eval_order/printIntInt(I)I
  ldc 21
  invokestatic eval_order/printIntInt(I)I
  if_icmpne L5
  pop 
  ldc 0
  L5:
  pop 
  ;; (bool) printIntBool (22) && printIntBool (23);
  ldc 22
  invokestatic eval_order/printIntBool(I)Z
  ifeq L6
  ldc 23
  invokestatic eval_order/printIntBool(I)Z
  ifeq L6
  ldc 1
  goto L7
  L6:
  ldc 0
  L7:
  pop 
  ;; (bool) printIntBool (24) || printIntBool (25);
  ldc 24
  invokestatic eval_order/printIntBool(I)Z
  ifeq L8
  ldc 1
  goto L9
  L8:
  ldc 25
  invokestatic eval_order/printIntBool(I)Z
  ifeq L10
  ldc 1
  goto L9
  L10:
  ldc 0
  L9:
  pop 
  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
