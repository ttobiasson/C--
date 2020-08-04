;; BEGIN HEADER

.class public good17
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

  invokestatic good17/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 3
  .limit stack  100
  ;; int x;
  ;; (int) x = 6;
  ldc 6
  nop
  dup
  istore 0
  pop 
  ;; int y;
  ;; (int) y = x int.+ 7;
  iload 0
  ldc 7
  iadd
  nop
  dup
  istore 1
  pop 
  ;; (void) printInt (y);
  iload 1
  invokestatic Runtime/printInt(I)V

  ;; {
  ;;   int y;
  ;;   (int) y = 4;
  ;;   (void) printInt (y);
  ;;   (int) x = y;
  ;;   (void) printInt (x);
  ;;   }
  ;; int y;
  ;; (int) y = 4;
  ldc 4
  nop
  dup
  istore 2
  pop 
  ;; (void) printInt (y);
  iload 2
  invokestatic Runtime/printInt(I)V

  ;; (int) x = y;
  iload 2
  nop
  dup
  istore 0
  pop 
  ;; (void) printInt (x);
  iload 0
  invokestatic Runtime/printInt(I)V

  ;; (void) printInt (x);
  iload 0
  invokestatic Runtime/printInt(I)V

  ;; (void) printInt (y);
  iload 1
  invokestatic Runtime/printInt(I)V

  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
