;; BEGIN HEADER

.class public boolean
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

  invokestatic boolean/main()I
  pop
  return

.end method

;; END HEADER

.method public static ff()Z
  .limit locals 0
  .limit stack  100
  ;; (void) printInt (0);
  ldc 0
  invokestatic Runtime/printInt(I)V

  ;; return (bool) false;
  ldc 0
  ireturn 
ireturn

.end method

.method public static tt()Z
  .limit locals 0
  .limit stack  100
  ;; (void) printInt (1);
  ldc 1
  invokestatic Runtime/printInt(I)V

  ;; return (bool) true;
  ldc 1
  ireturn 
ireturn

.end method

.method public static main()I
  .limit locals 6
  .limit stack  100
  ;; bool t = true;
  ldc 1
  istore 0
  ;; bool f = false;
  ldc 0
  istore 1
  ;; bool silent1 = f && ff ();
  iload 1
  ifeq L0
  invokestatic boolean/ff()Z
  ifeq L0
  ldc 1
  goto L1
  L0:
  ldc 0
  L1:
  istore 2
  ;; bool silent2 = t || ff ();
  iload 0
  ifeq L2
  ldc 1
  goto L3
  L2:
  invokestatic boolean/ff()Z
  ifeq L4
  ldc 1
  goto L3
  L4:
  ldc 0
  L3:
  istore 3
  ;; bool noisy1 = t && tt ();
  iload 0
  ifeq L5
  invokestatic boolean/tt()Z
  ifeq L5
  ldc 1
  goto L6
  L5:
  ldc 0
  L6:
  istore 4
  ;; bool noisy2 = f || tt ();
  iload 1
  ifeq L7
  ldc 1
  goto L8
  L7:
  invokestatic boolean/tt()Z
  ifeq L9
  ldc 1
  goto L8
  L9:
  ldc 0
  L8:
  istore 5
  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
