;; BEGIN HEADER

.class public scopes
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

  invokestatic scopes/main()I
  pop
  return

.end method

;; END HEADER

.method public static f()I
  .limit locals 2
  .limit stack  100
  ;; int n = 2;
  ldc 2
  istore 0
  ;; if (n int.< 3) {
  ;;   int n = 3;
  ;;   return (int) n;
  ;;   }
  ;; else {
  ;;   }
  ldc 1
  iload 0
  ldc 3
  if_icmplt L2
  pop 
  ldc 0
  L2:
  ifeq L1
  ;; {
  ;;   int n = 3;
  ;;   return (int) n;
  ;;   }
  ;; int n = 3;
  ldc 3
  istore 1
  ;; return (int) n;
  iload 1
  ireturn 
  goto L0
  L1:
  ;; {
  ;;   }
  L0:
  ;; return (int) n;
  iload 0
  ireturn 
ireturn

.end method

.method public static main()I
  .limit locals 1
  .limit stack  100
  ;; int n = 1;
  ldc 1
  istore 0
  ;; (void) printInt (n);
  iload 0
  invokestatic Runtime/printInt(I)V

  ;; (void) printInt (f ());
  invokestatic scopes/f()I
  invokestatic Runtime/printInt(I)V

  ;; (void) printInt (n);
  iload 0
  invokestatic Runtime/printInt(I)V

  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
