;; BEGIN HEADER

.class public large_program_fac
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

  invokestatic large_program_fac/main()I
  pop
  return

.end method

;; END HEADER

.method public static fac(I)I
  .limit locals 3
  .limit stack  100
  ;; int r;
  ;; int n;
  ;; (int) r = 1;
  ldc 1
  nop
  dup
  istore 1
  pop 
  ;; (int) n = a;
  iload 0
  nop
  dup
  istore 2
  pop 
  ;; while (n int.> 0)
  L0:
  ldc 1
  iload 2
  ldc 0
  if_icmpgt L2
  pop 
  ldc 0
  L2:
  ifeq L1
  ;; {
  ;;   (int) r = r int.* n;
  ;;   (int) n = n int.- 1;
  ;;   }
  ;; (int) r = r int.* n;
  iload 1
  iload 2
  imul
  nop
  dup
  istore 1
  pop 
  ;; (int) n = n int.- 1;
  iload 2
  ldc 1
  isub
  nop
  dup
  istore 2
  pop 
  goto L0
  L1:
  ;; return (int) r;
  iload 1
  ireturn 
ireturn

.end method

.method public static rfac(I)I
  .limit locals 2
  .limit stack  100
  ;; int f;
  ;; if (n int.== 0) (int) f = 1;
  ;; else (int) f = n int.* rfac (n int.- 1);
  ldc 1
  iload 0
  ldc 0
  if_icmpeq L5
  pop 
  ldc 0
  L5:
  ifeq L4
  ;; (int) f = 1;
  ldc 1
  nop
  dup
  istore 1
  pop 
  goto L3
  L4:
  ;; (int) f = n int.* rfac (n int.- 1);
  iload 0
  iload 0
  ldc 1
  isub
  invokestatic large_program_fac/rfac(I)I
  imul
  nop
  dup
  istore 1
  pop 
  L3:
  ;; return (int) f;
  iload 1
  ireturn 
ireturn

.end method

.method public static mfac(I)I
  .limit locals 2
  .limit stack  100
  ;; int f;
  ;; if (n int.== 0) (int) f = 1;
  ;; else (int) f = n int.* nfac (n int.- 1);
  ldc 1
  iload 0
  ldc 0
  if_icmpeq L8
  pop 
  ldc 0
  L8:
  ifeq L7
  ;; (int) f = 1;
  ldc 1
  nop
  dup
  istore 1
  pop 
  goto L6
  L7:
  ;; (int) f = n int.* nfac (n int.- 1);
  iload 0
  iload 0
  ldc 1
  isub
  invokestatic large_program_fac/nfac(I)I
  imul
  nop
  dup
  istore 1
  pop 
  L6:
  ;; return (int) f;
  iload 1
  ireturn 
ireturn

.end method

.method public static nfac(I)I
  .limit locals 2
  .limit stack  100
  ;; int f;
  ;; if (n int.!= 0) (int) f = mfac (n int.- 1) int.* n;
  ;; else (int) f = 1;
  ldc 1
  iload 0
  ldc 0
  if_icmpne L11
  pop 
  ldc 0
  L11:
  ifeq L10
  ;; (int) f = mfac (n int.- 1) int.* n;
  iload 0
  ldc 1
  isub
  invokestatic large_program_fac/mfac(I)I
  iload 0
  imul
  nop
  dup
  istore 1
  pop 
  goto L9
  L10:
  ;; (int) f = 1;
  ldc 1
  nop
  dup
  istore 1
  pop 
  L9:
  ;; return (int) f;
  iload 1
  ireturn 
ireturn

.end method

.method public static ifac2f(II)I
  .limit locals 4
  .limit stack  100
  ;; int f;
  ;; if (l int.== h) (int) f = l;
  ;; else if (l int.> h) (int) f = 1;
  ;; else {
  ;;   int m;
  ;;   (int) m = (l int.+ h) int./ 2;
  ;;   (int) f = ifac2f (l, m) int.* ifac2f (m int.+ 1, h);
  ;;   }
  ldc 1
  iload 0
  iload 1
  if_icmpeq L14
  pop 
  ldc 0
  L14:
  ifeq L13
  ;; (int) f = l;
  iload 0
  nop
  dup
  istore 2
  pop 
  goto L12
  L13:
  ;; if (l int.> h) (int) f = 1;
  ;; else {
  ;;   int m;
  ;;   (int) m = (l int.+ h) int./ 2;
  ;;   (int) f = ifac2f (l, m) int.* ifac2f (m int.+ 1, h);
  ;;   }
  ldc 1
  iload 0
  iload 1
  if_icmpgt L17
  pop 
  ldc 0
  L17:
  ifeq L16
  ;; (int) f = 1;
  ldc 1
  nop
  dup
  istore 2
  pop 
  goto L15
  L16:
  ;; {
  ;;   int m;
  ;;   (int) m = (l int.+ h) int./ 2;
  ;;   (int) f = ifac2f (l, m) int.* ifac2f (m int.+ 1, h);
  ;;   }
  ;; int m;
  ;; (int) m = (l int.+ h) int./ 2;
  iload 0
  iload 1
  iadd
  ldc 2
  idiv
  nop
  dup
  istore 3
  pop 
  ;; (int) f = ifac2f (l, m) int.* ifac2f (m int.+ 1, h);
  iload 0
  iload 3
  invokestatic large_program_fac/ifac2f(II)I
  iload 3
  ldc 1
  iadd
  iload 1
  invokestatic large_program_fac/ifac2f(II)I
  imul
  nop
  dup
  istore 2
  pop 
  L15:
  L12:
  ;; return (int) f;
  iload 2
  ireturn 
ireturn

.end method

.method public static ifac(I)I
  .limit locals 1
  .limit stack  100
  ;; return (int) ifac2f (1, n);
  ldc 1
  iload 0
  invokestatic large_program_fac/ifac2f(II)I
  ireturn 
ireturn

.end method

.method public static main()I
  .limit locals 0
  .limit stack  100
  ;; (void) printInt (fac (10));
  ldc 10
  invokestatic large_program_fac/fac(I)I
  invokestatic Runtime/printInt(I)V

  ;; (void) printInt (rfac (10));
  ldc 10
  invokestatic large_program_fac/rfac(I)I
  invokestatic Runtime/printInt(I)V

  ;; (void) printInt (mfac (10));
  ldc 10
  invokestatic large_program_fac/mfac(I)I
  invokestatic Runtime/printInt(I)V

  ;; (void) printInt (ifac (10));
  ldc 10
  invokestatic large_program_fac/ifac(I)I
  invokestatic Runtime/printInt(I)V

  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
