;; BEGIN HEADER

.class public ineq_inclusive
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

  invokestatic ineq_inclusive/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 0
  .limit stack  100
  ;; if (0 int.>= 0) (void) printInt (0);
  ;; else (void) printInt (1);
  ldc 1
  ldc 0
  ldc 0
  if_icmpge L2
  pop 
  ldc 0
  L2:
  ifeq L1
  ;; (void) printInt (0);
  ldc 0
  invokestatic Runtime/printInt(I)V

  goto L0
  L1:
  ;; (void) printInt (1);
  ldc 1
  invokestatic Runtime/printInt(I)V

  L0:
  ;; if (1 int.>= 1) (void) printInt (2);
  ;; else (void) printInt (3);
  ldc 1
  ldc 1
  ldc 1
  if_icmpge L5
  pop 
  ldc 0
  L5:
  ifeq L4
  ;; (void) printInt (2);
  ldc 2
  invokestatic Runtime/printInt(I)V

  goto L3
  L4:
  ;; (void) printInt (3);
  ldc 3
  invokestatic Runtime/printInt(I)V

  L3:
  ;; if (2 int.<= 2) (void) printInt (4);
  ;; else (void) printInt (5);
  ldc 1
  ldc 2
  ldc 2
  if_icmple L8
  pop 
  ldc 0
  L8:
  ifeq L7
  ;; (void) printInt (4);
  ldc 4
  invokestatic Runtime/printInt(I)V

  goto L6
  L7:
  ;; (void) printInt (5);
  ldc 5
  invokestatic Runtime/printInt(I)V

  L6:
  ;; if (0 int.<= 0) (void) printInt (6);
  ;; else (void) printInt (7);
  ldc 1
  ldc 0
  ldc 0
  if_icmple L11
  pop 
  ldc 0
  L11:
  ifeq L10
  ;; (void) printInt (6);
  ldc 6
  invokestatic Runtime/printInt(I)V

  goto L9
  L10:
  ;; (void) printInt (7);
  ldc 7
  invokestatic Runtime/printInt(I)V

  L9:
  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
