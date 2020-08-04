;; BEGIN HEADER

.class public core017
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

  invokestatic core017/main()I
  pop
  return

.end method

;; END HEADER

.method public static dontCallMe(I)Z
  .limit locals 1
  .limit stack  100
  ;; (void) printInt (x);
  iload 0
  invokestatic Runtime/printInt(I)V

  ;; return (bool) true;
  ldc 1
  ireturn 
ireturn

.end method

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

.method public static neg(Z)Z
  .limit locals 2
  .limit stack  100
  ;; bool r;
  ;; if (x) (bool) r = false;
  ;; else (bool) r = true;
  iload 0
  ifeq L3
  ;; (bool) r = false;
  ldc 0
  dup
  istore 1
  pop 
  goto L2
  L3:
  ;; (bool) r = true;
  ldc 1
  dup
  istore 1
  pop 
  L2:
  ;; return (bool) r;
  iload 1
  ireturn 
ireturn

.end method

.method public static eq_bool(ZZ)Z
  .limit locals 3
  .limit stack  100
  ;; bool r;
  ;; if (x) (bool) r = y;
  ;; else (bool) r = neg (y);
  iload 0
  ifeq L5
  ;; (bool) r = y;
  iload 1
  dup
  istore 2
  pop 
  goto L4
  L5:
  ;; (bool) r = neg (y);
  iload 1
  invokestatic core017/neg(Z)Z
  dup
  istore 2
  pop 
  L4:
  ;; return (bool) r;
  iload 2
  ireturn 
ireturn

.end method

.method public static implies(ZZ)Z
  .limit locals 2
  .limit stack  100
  ;; return (bool) neg (x) || eq_bool (x, y);
  iload 0
  invokestatic core017/neg(Z)Z
  ifeq L6
  ldc 1
  goto L7
  L6:
  iload 0
  iload 1
  invokestatic core017/eq_bool(ZZ)Z
  ifeq L8
  ldc 1
  goto L7
  L8:
  ldc 0
  L7:
  ireturn 
ireturn

.end method

.method public static main()I
  .limit locals 1
  .limit stack  100
  ;; int x = 4;
  ldc 4
  istore 0
  ;; if (true) {
  ;;   (void) printBool (true);
  ;;   }
  ;; else {
  ;;   }
  ldc 1
  ifeq L10
  ;; {
  ;;   (void) printBool (true);
  ;;   }
  ;; (void) printBool (true);
  ldc 1
  invokestatic core017/printBool(Z)V

  goto L9
  L10:
  ;; {
  ;;   }
  L9:
  ;; (void) printBool (eq_bool (true, true) || dontCallMe (1));
  ldc 1
  ldc 1
  invokestatic core017/eq_bool(ZZ)Z
  ifeq L11
  ldc 1
  goto L12
  L11:
  ldc 1
  invokestatic core017/dontCallMe(I)Z
  ifeq L13
  ldc 1
  goto L12
  L13:
  ldc 0
  L12:
  invokestatic core017/printBool(Z)V

  ;; (void) printBool (4 int.> 50 && dontCallMe (2));
  ldc 1
  ldc 4
  ldc 50
  if_icmpgt L14
  pop 
  ldc 0
  L14:
  ifeq L15
  ldc 2
  invokestatic core017/dontCallMe(I)Z
  ifeq L15
  ldc 1
  goto L16
  L15:
  ldc 0
  L16:
  invokestatic core017/printBool(Z)V

  ;; (void) printBool (4 int.== x && eq_bool (true, false) && true);
  ldc 1
  ldc 4
  iload 0
  if_icmpeq L17
  pop 
  ldc 0
  L17:
  ifeq L18
  ldc 1
  ldc 0
  invokestatic core017/eq_bool(ZZ)Z
  ifeq L18
  ldc 1
  goto L19
  L18:
  ldc 0
  L19:
  ifeq L20
  ldc 1
  ifeq L20
  ldc 1
  goto L21
  L20:
  ldc 0
  L21:
  invokestatic core017/printBool(Z)V

  ;; (void) printBool (implies (false, false));
  ldc 0
  ldc 0
  invokestatic core017/implies(ZZ)Z
  invokestatic core017/printBool(Z)V

  ;; (void) printBool (implies (false, true));
  ldc 0
  ldc 1
  invokestatic core017/implies(ZZ)Z
  invokestatic core017/printBool(Z)V

  ;; (void) printBool (implies (true, false));
  ldc 1
  ldc 0
  invokestatic core017/implies(ZZ)Z
  invokestatic core017/printBool(Z)V

  ;; (void) printBool (implies (true, true));
  ldc 1
  ldc 1
  invokestatic core017/implies(ZZ)Z
  invokestatic core017/printBool(Z)V

  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
