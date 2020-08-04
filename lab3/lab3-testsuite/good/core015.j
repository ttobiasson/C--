;; BEGIN HEADER

.class public core015
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

  invokestatic core015/main()I
  pop
  return

.end method

;; END HEADER

.method public static ev(I)I
  .limit locals 2
  .limit stack  100
  ;; int e;
  ;; if (y int.> 0) (int) e = ev (y int.- 2);
  ;; else if (y int.< 0) (int) e = 0;
  ;; else (int) e = 1;
  ldc 1
  iload 0
  ldc 0
  if_icmpgt L2
  pop 
  ldc 0
  L2:
  ifeq L1
  ;; (int) e = ev (y int.- 2);
  iload 0
  ldc 2
  isub
  invokestatic core015/ev(I)I
  nop
  dup
  istore 1
  pop 
  goto L0
  L1:
  ;; if (y int.< 0) (int) e = 0;
  ;; else (int) e = 1;
  ldc 1
  iload 0
  ldc 0
  if_icmplt L5
  pop 
  ldc 0
  L5:
  ifeq L4
  ;; (int) e = 0;
  ldc 0
  nop
  dup
  istore 1
  pop 
  goto L3
  L4:
  ;; (int) e = 1;
  ldc 1
  nop
  dup
  istore 1
  pop 
  L3:
  L0:
  ;; return (int) e;
  iload 1
  ireturn 
ireturn

.end method

.method public static main()I
  .limit locals 0
  .limit stack  100
  ;; (void) printInt (ev (17));
  ldc 17
  invokestatic core015/ev(I)I
  invokestatic Runtime/printInt(I)V

  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
