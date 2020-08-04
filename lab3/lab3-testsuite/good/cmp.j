;; BEGIN HEADER

.class public cmp
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

  invokestatic cmp/main()I
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
  ;; (void) printBool (30 int.== 40);
  ldc 1
  ldc 30
  ldc 40
  if_icmpeq L2
  pop 
  ldc 0
  L2:
  invokestatic cmp/printBool(Z)V

  ;; (void) printBool (30 int.== 30);
  ldc 1
  ldc 30
  ldc 30
  if_icmpeq L3
  pop 
  ldc 0
  L3:
  invokestatic cmp/printBool(Z)V

  ;; (void) printBool (30 int.!= 30);
  ldc 1
  ldc 30
  ldc 30
  if_icmpne L4
  pop 
  ldc 0
  L4:
  invokestatic cmp/printBool(Z)V

  ;; (void) printBool (40 int.!= 40);
  ldc 1
  ldc 40
  ldc 40
  if_icmpne L5
  pop 
  ldc 0
  L5:
  invokestatic cmp/printBool(Z)V

  ;; (void) printBool (3 int.> 4);
  ldc 1
  ldc 3
  ldc 4
  if_icmpgt L6
  pop 
  ldc 0
  L6:
  invokestatic cmp/printBool(Z)V

  ;; (void) printBool (3 int.> 3);
  ldc 1
  ldc 3
  ldc 3
  if_icmpgt L7
  pop 
  ldc 0
  L7:
  invokestatic cmp/printBool(Z)V

  ;; (void) printBool (4 int.< 3);
  ldc 1
  ldc 4
  ldc 3
  if_icmplt L8
  pop 
  ldc 0
  L8:
  invokestatic cmp/printBool(Z)V

  ;; (void) printBool (4 int.< 4);
  ldc 1
  ldc 4
  ldc 4
  if_icmplt L9
  pop 
  ldc 0
  L9:
  invokestatic cmp/printBool(Z)V

  ;; (void) printBool (400 int.>= 300);
  ldc 1
  ldc 400
  ldc 300
  if_icmpge L10
  pop 
  ldc 0
  L10:
  invokestatic cmp/printBool(Z)V

  ;; (void) printBool (400 int.>= 400);
  ldc 1
  ldc 400
  ldc 400
  if_icmpge L11
  pop 
  ldc 0
  L11:
  invokestatic cmp/printBool(Z)V

  ;; (void) printBool (400 int.<= 300);
  ldc 1
  ldc 400
  ldc 300
  if_icmple L12
  pop 
  ldc 0
  L12:
  invokestatic cmp/printBool(Z)V

  ;; (void) printBool (400 int.<= 400);
  ldc 1
  ldc 400
  ldc 400
  if_icmple L13
  pop 
  ldc 0
  L13:
  invokestatic cmp/printBool(Z)V

  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
