;; BEGIN HEADER

.class public double__cmp
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

  invokestatic double__cmp/main()I
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
  .limit locals 4
  .limit stack  100
  ;; double big = 1.5;
  ldc2_w 1.5
  dstore 0
  ;; double small = 0.5;
  ldc2_w 0.5
  dstore 2
  ;; (void) printBool (big double.== big);
  dload 0
  dload 0
  dcmpg
  ifeq L2
  ldc 0
  goto L3
  L2:
  ldc 1
  L3:
  invokestatic double__cmp/printBool(Z)V

  ;; (void) printBool (big double.!= big);
  dload 0
  dload 0
  dcmpg
  ifne L4
  ldc 0
  goto L5
  L4:
  ldc 1
  L5:
  invokestatic double__cmp/printBool(Z)V

  ;; (void) printBool (big double.> small);
  dload 0
  dload 2
  dcmpg
  ifgt L6
  ldc 0
  goto L7
  L6:
  ldc 1
  L7:
  invokestatic double__cmp/printBool(Z)V

  ;; (void) printBool (big double.> big);
  dload 0
  dload 0
  dcmpg
  ifgt L8
  ldc 0
  goto L9
  L8:
  ldc 1
  L9:
  invokestatic double__cmp/printBool(Z)V

  ;; (void) printBool (small double.>= big);
  dload 2
  dload 0
  dcmpg
  ifge L10
  ldc 0
  goto L11
  L10:
  ldc 1
  L11:
  invokestatic double__cmp/printBool(Z)V

  ;; (void) printBool (small double.>= small);
  dload 2
  dload 2
  dcmpg
  ifge L12
  ldc 0
  goto L13
  L12:
  ldc 1
  L13:
  invokestatic double__cmp/printBool(Z)V

  ;; (void) printBool (small double.< big);
  dload 2
  dload 0
  dcmpl
  iflt L14
  ldc 0
  goto L15
  L14:
  ldc 1
  L15:
  invokestatic double__cmp/printBool(Z)V

  ;; (void) printBool (big double.< big);
  dload 0
  dload 0
  dcmpl
  iflt L16
  ldc 0
  goto L17
  L16:
  ldc 1
  L17:
  invokestatic double__cmp/printBool(Z)V

  ;; (void) printBool (small double.<= big);
  dload 2
  dload 0
  dcmpl
  ifle L18
  ldc 0
  goto L19
  L18:
  ldc 1
  L19:
  invokestatic double__cmp/printBool(Z)V

  ;; (void) printBool (small double.<= small);
  dload 2
  dload 2
  dcmpl
  ifle L20
  ldc 0
  goto L21
  L20:
  ldc 1
  L21:
  invokestatic double__cmp/printBool(Z)V

  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
