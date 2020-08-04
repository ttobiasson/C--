;; BEGIN HEADER

.class public core005
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

  invokestatic core005/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 2
  .limit stack  100
  ;; int x;
  ;; int y = 56;
  ldc 56
  istore 1
  ;; if (y int.+ 45 int.<= 2) {
  ;;   (int) x = 1;
  ;;   }
  ;; else {
  ;;   (int) x = 2;
  ;;   }
  ldc 1
  iload 1
  ldc 45
  iadd
  ldc 2
  if_icmple L2
  pop 
  ldc 0
  L2:
  ifeq L1
  ;; {
  ;;   (int) x = 1;
  ;;   }
  ;; (int) x = 1;
  ldc 1
  nop
  dup
  istore 0
  pop 
  goto L0
  L1:
  ;; {
  ;;   (int) x = 2;
  ;;   }
  ;; (int) x = 2;
  ldc 2
  nop
  dup
  istore 0
  pop 
  L0:
  ;; (void) printInt (x);
  iload 0
  invokestatic Runtime/printInt(I)V

  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
