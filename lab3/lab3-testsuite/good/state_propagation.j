;; BEGIN HEADER

.class public state_propagation
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

  invokestatic state_propagation/main()I
  pop
  return

.end method

;; END HEADER

.method public static id(I)I
  .limit locals 1
  .limit stack  100
  ;; return (int) x;
  iload 0
  ireturn 
ireturn

.end method

.method public static main()I
  .limit locals 1
  .limit stack  100
  ;; int z = 0;
  ldc 0
  istore 0
  ;; (int) id (++ z);
  iload 0
  ldc 1
  iadd
  dup
  istore 0
  invokestatic state_propagation/id(I)I
  pop 
  ;; (void) printInt (z);
  iload 0
  invokestatic Runtime/printInt(I)V

  ;; (int) id (z = z int.+ 1);
  iload 0
  ldc 1
  iadd
  nop
  dup
  istore 0
  invokestatic state_propagation/id(I)I
  pop 
  ;; (void) printInt (z);
  iload 0
  invokestatic Runtime/printInt(I)V

  ;; (int) z ++ int.+ z ++;
  iload 0
  dup
  ldc 1
  iadd
  istore 0
  iload 0
  dup
  ldc 1
  iadd
  istore 0
  iadd
  pop 
  ;; (void) printInt (z);
  iload 0
  invokestatic Runtime/printInt(I)V

  ;; (bool) z ++ int.== z ++;
  ldc 1
  iload 0
  dup
  ldc 1
  iadd
  istore 0
  iload 0
  dup
  ldc 1
  iadd
  istore 0
  if_icmpeq L0
  pop 
  ldc 0
  L0:
  pop 
  ;; (void) printInt (z);
  iload 0
  invokestatic Runtime/printInt(I)V

  ;; if (++ z int.== 7) {
  ;;   (void) printInt (z);
  ;;   }
  ;; else {
  ;;   }
  ldc 1
  iload 0
  ldc 1
  iadd
  dup
  istore 0
  ldc 7
  if_icmpeq L3
  pop 
  ldc 0
  L3:
  ifeq L2
  ;; {
  ;;   (void) printInt (z);
  ;;   }
  ;; (void) printInt (z);
  iload 0
  invokestatic Runtime/printInt(I)V

  goto L1
  L2:
  ;; {
  ;;   }
  L1:
  ;; (void) printInt (z);
  iload 0
  invokestatic Runtime/printInt(I)V

  ;; if (z ++ int.== 8) {
  ;;   }
  ;; else {
  ;;   (void) printInt (z);
  ;;   }
  ldc 1
  iload 0
  dup
  ldc 1
  iadd
  istore 0
  ldc 8
  if_icmpeq L6
  pop 
  ldc 0
  L6:
  ifeq L5
  ;; {
  ;;   }
  goto L4
  L5:
  ;; {
  ;;   (void) printInt (z);
  ;;   }
  ;; (void) printInt (z);
  iload 0
  invokestatic Runtime/printInt(I)V

  L4:
  ;; (void) printInt (z);
  iload 0
  invokestatic Runtime/printInt(I)V

  ;; while (++ z int.== 9)
  L7:
  ldc 1
  iload 0
  ldc 1
  iadd
  dup
  istore 0
  ldc 9
  if_icmpeq L9
  pop 
  ldc 0
  L9:
  ifeq L8
  ;; {
  ;;   (void) printInt (z);
  ;;   }
  ;; (void) printInt (z);
  iload 0
  invokestatic Runtime/printInt(I)V

  goto L7
  L8:
  ;; (void) printInt (z);
  iload 0
  invokestatic Runtime/printInt(I)V

  ;; while (z ++ int.== 11)
  L10:
  ldc 1
  iload 0
  dup
  ldc 1
  iadd
  istore 0
  ldc 11
  if_icmpeq L12
  pop 
  ldc 0
  L12:
  ifeq L11
  ;; {
  ;;   }
  goto L10
  L11:
  ;; (void) printInt (z);
  iload 0
  invokestatic Runtime/printInt(I)V

  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
