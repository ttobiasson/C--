;; BEGIN HEADER

.class public good11
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

  invokestatic good11/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 3
  .limit stack  100
  ;; int sum = 0;
  ldc 0
  istore 0
  ;; int num = 0;
  ldc 0
  istore 1
  ;; int x;
  ;; while ((x = readInt ()) int.!= 0)
  L0:
  ldc 1
  invokestatic Runtime/readInt()I
  nop
  dup
  istore 2
  ldc 0
  if_icmpne L2
  pop 
  ldc 0
  L2:
  ifeq L1
  ;; {
  ;;   (int) sum = sum int.+ x;
  ;;   (int) num ++;
  ;;   }
  ;; (int) sum = sum int.+ x;
  iload 0
  iload 2
  iadd
  nop
  dup
  istore 0
  pop 
  ;; (int) num ++;
  iload 1
  dup
  ldc 1
  iadd
  istore 1
  pop 
  goto L0
  L1:
  ;; (void) printInt (sum int./ num);
  iload 0
  iload 1
  idiv
  invokestatic Runtime/printInt(I)V

  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
