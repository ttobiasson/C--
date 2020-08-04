;; BEGIN HEADER

.class public cmp_if_int_lte_double
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

  invokestatic cmp_if_int_lte_double/main()I
  pop
  return

.end method

;; END HEADER

.method public static main()I
  .limit locals 1
  .limit stack  100
  ;; if (3 double.<= 5.0) int y;
  ;; else {
  ;;   }
  ldc2_w 5.0
  ldc 3
  i2d
  dcmpl
  ifle L2
  ldc 0
  goto L3
  L2:
  ldc 1
  L3:
  ifeq L1
  ;; int y;
  goto L0
  L1:
  ;; {
  ;;   }
  L0:
  ;; return (int) 0;
  ldc 0
  ireturn 
ireturn

.end method
