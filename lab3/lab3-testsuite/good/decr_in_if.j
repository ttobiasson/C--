;; BEGIN HEADER

.class public decr_in_if
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

  invokestatic decr_in_if/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 1
  .limit stack  100
  ;; int uw = 0;
  ldc 0
  istore 0
  ;; if (uw -- int.>= 0) (int) 0;
  ;; else (int) 0;
  ldc 1
  iload 0
  dup
  ldc 1
  isub
  istore 0
  ldc 0
  if_icmpge L2
  pop 
  ldc 0
  L2:
  ifeq L1
  ;; (int) 0;
  ldc 0
  pop 
  goto L0
  L1:
  ;; (int) 0;
  ldc 0
  pop 
  L0:
  ;; (void) printInt (uw);
  iload 0
  invokestatic Runtime/printInt(I)V

  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
