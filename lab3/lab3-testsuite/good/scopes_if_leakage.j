;; BEGIN HEADER

.class public scopes_if_leakage
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

  invokestatic scopes_if_leakage/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 7
  .limit stack  100
  ;; bool var = true;
  ldc 1
  istore 0
  ;; if (true) int var = 1;
  ;; else int var = 0;
  ldc 1
  ifeq L1
  ;; int var = 1;
  ldc 1
  istore 1
  goto L0
  L1:
  ;; int var = 0;
  ldc 0
  istore 2
  L0:
  ;; (bool) var bool.== true;
  ldc 1
  iload 0
  ldc 1
  if_icmpeq L2
  pop 
  ldc 0
  L2:
  pop 
  ;; bool var1 = var;
  iload 0
  istore 3
  ;; if (false) int var = 1;
  ;; else int var = 0;
  ldc 0
  ifeq L4
  ;; int var = 1;
  ldc 1
  istore 4
  goto L3
  L4:
  ;; int var = 0;
  ldc 0
  istore 5
  L3:
  ;; (bool) var bool.== true;
  ldc 1
  iload 0
  ldc 1
  if_icmpeq L5
  pop 
  ldc 0
  L5:
  pop 
  ;; bool var2 = var;
  iload 0
  istore 6
  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
