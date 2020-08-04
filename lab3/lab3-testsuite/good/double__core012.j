;; BEGIN HEADER

.class public double__core012
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

  invokestatic double__core012/main()I
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

.method public static main()I
  .limit locals 4
  .limit stack  100
  ;; double z = 9.3;
  ldc2_w 9.3
  dstore 0
  ;; double w = 5.1;
  ldc2_w 5.1
  dstore 2
  ;; (void) printBool (z double.+ w double.> z double.- w);
  dload 0
  dload 2
  dadd
  dload 0
  dload 2
  dsub
  dcmpg
  ifgt L2
  ldc 0
  goto L3
  L2:
  ldc 1
  L3:
  invokestatic double__core012/printBool(Z)V

  ;; (void) printBool (z double./ w double.<= z double.* w);
  dload 0
  dload 2
  ddiv
  dload 0
  dload 2
  dmul
  dcmpl
  ifle L4
  ldc 0
  goto L5
  L4:
  ldc 1
  L5:
  invokestatic double__core012/printBool(Z)V

  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
