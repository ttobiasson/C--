;; BEGIN HEADER

.class public double__small_program_fac
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

  invokestatic double__small_program_fac/main()I
  pop
  return

.end method

;; END HEADER

.method public static dfac(D)D
  .limit locals 4
  .limit stack  100
  ;; double f;
  ;; if (n double.== 0.0) (double) f = 1.0;
  ;; else (double) f = n double.* dfac (n double.- 1.0);
  dload 0
  ldc2_w 0.0
  dcmpg
  ifeq L2
  ldc 0
  goto L3
  L2:
  ldc 1
  L3:
  ifeq L1
  ;; (double) f = 1.0;
  ldc2_w 1.0
  nop
  dup2
  dstore 2
  pop2 
  goto L0
  L1:
  ;; (double) f = n double.* dfac (n double.- 1.0);
  dload 0
  dload 0
  ldc2_w 1.0
  dsub
  invokestatic double__small_program_fac/dfac(D)D
  dmul
  nop
  dup2
  dstore 2
  pop2 
  L0:
  ;; return (double) f;
  dload 2
  dreturn 
dreturn

.end method

.method public static main()I
  .limit locals 4
  .limit stack  100
  ;; double r;
  ;; {
  ;;   int n = 10;
  ;;   int r = 1;
  ;;   while (n int.> 0) {
  ;;     (int) r = r int.* n;
  ;;     (int) n = n int.- 1;
  ;;     }
  ;;   (void) printInt (r);
  ;;   }
  ;; int n = 10;
  ldc 10
  istore 2
  ;; int r = 1;
  ldc 1
  istore 3
  ;; while (n int.> 0)
  L4:
  ldc 1
  iload 2
  ldc 0
  if_icmpgt L6
  pop 
  ldc 0
  L6:
  ifeq L5
  ;; {
  ;;   (int) r = r int.* n;
  ;;   (int) n = n int.- 1;
  ;;   }
  ;; (int) r = r int.* n;
  iload 3
  iload 2
  imul
  nop
  dup
  istore 3
  pop 
  ;; (int) n = n int.- 1;
  iload 2
  ldc 1
  isub
  nop
  dup
  istore 2
  pop 
  goto L4
  L5:
  ;; (void) printInt (r);
  iload 3
  invokestatic Runtime/printInt(I)V

  ;; (void) printDouble (dfac (10.0));
  ldc2_w 10.0
  invokestatic double__small_program_fac/dfac(D)D
  invokestatic Runtime/printDouble(D)V

  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
