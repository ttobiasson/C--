;; BEGIN HEADER

.class public good05
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

  invokestatic good05/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 3
  .limit stack  100
  ;; int lo, hi, mx;
  ;; (int) lo = 1;
  ldc 1
  nop
  dup
  istore 0
  pop 
  ;; (int) hi = lo;
  iload 0
  nop
  dup
  istore 1
  pop 
  ;; (int) mx = readInt ();
  invokestatic Runtime/readInt()I
  nop
  dup
  istore 2
  pop 
  ;; (void) printInt (lo);
  iload 0
  invokestatic Runtime/printInt(I)V

  ;; while (hi int.< mx)
  L0:
  ldc 1
  iload 1
  iload 2
  if_icmplt L2
  pop 
  ldc 0
  L2:
  ifeq L1
  ;; {
  ;;   (void) printInt (hi);
  ;;   (int) hi = lo int.+ hi;
  ;;   (int) lo = hi int.- lo;
  ;;   }
  ;; (void) printInt (hi);
  iload 1
  invokestatic Runtime/printInt(I)V

  ;; (int) hi = lo int.+ hi;
  iload 0
  iload 1
  iadd
  nop
  dup
  istore 1
  pop 
  ;; (int) lo = hi int.- lo;
  iload 1
  iload 0
  isub
  nop
  dup
  istore 0
  pop 
  goto L0
  L1:
  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
