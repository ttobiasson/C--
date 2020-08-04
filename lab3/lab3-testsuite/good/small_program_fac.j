;; BEGIN HEADER

.class public small_program_fac
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

  invokestatic small_program_fac/main()I
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

.method public static main()I
  .limit locals 0
  .limit stack  100
  ;; (void) printInt (fac (5));
  ldc 5
  invokestatic small_program_fac/fac(I)I
  invokestatic Runtime/printInt(I)V

  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
