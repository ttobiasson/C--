;; BEGIN HEADER

.class public scopes_different_type_in_branches
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

  invokestatic scopes_different_type_in_branches/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 2
  .limit stack  100
  ;; if (1 int.> 0) {
  ;;   int x = 0;
  ;;   }
  ;; else {
  ;;   bool x = true;
  ;;   }
  ldc 1
  ldc 1
  ldc 0
  if_icmpgt L2
  pop 
  ldc 0
  L2:
  ifeq L1
  ;; {
  ;;   int x = 0;
  ;;   }
  ;; int x = 0;
  ldc 0
  istore 0
  goto L0
  L1:
  ;; {
  ;;   bool x = true;
  ;;   }
  ;; bool x = true;
  ldc 1
  istore 1
  L0:
  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
